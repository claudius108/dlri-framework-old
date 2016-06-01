xquery version "3.0";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace dlri-views = "http://dlri.ro/ns/dlri-views";
declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace html = "http://www.w3.org/1999/xhtml";

declare variable $framework-dir := dlri-utils:expandEditorVariables("${framework(dlri)}");
declare variable $entry := /*//tei:entry;
declare variable $entry-title := dlri-views:get-entry-title($entry);
declare variable $language-codes := doc("../resources/controlled-vocabularies/languages.xml");

declare function dlri-views:dispatch($node) {
    typeswitch($node)
        case text() return $node
        case element(tei:hi) return dlri-views:hi($node)
        default return dlri-views:passthru($node)
};

declare function dlri-views:passthru($nodes) {
    for $node in $nodes/node() return dlri-views:dispatch($node)
};

declare function dlri-views:form($node) {
	let $type := $node/@type
	
	return
		switch ($type) 
		   case "phrase" return dlri-views:form-phrase($node)
		   default return ()
};

declare function dlri-views:form-phrase($node) {
  (
    <span class="spacing">Expr.</span>,
    dlri-views:passthru($node)
  )
};

declare function dlri-views:hi($node) {
  <span class="{$node/@rend}">{$node/text()}</span>
};

declare function local:dispatch($node) {
    typeswitch($node)
        case text() return $node
        case element(tei:usg) return local:usg($node)
        case element(tei:form) return dlri-views:form($node)
        case element(tei:hi) return dlri-views:hi($node)
        default return local:passthru($node)
};

declare function local:passthru($nodes) {
    for $node in $nodes/node() return local:dispatch($node)
};

declare function local:process-sense-content($node as element(tei:sense)) {
  local:passthru($node)
};

declare function local:xr-synonym($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'syn']) eq 0) then ";" else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'syn']) eq 0) then ". " else ()
  )
};

declare function local:xr-analogy($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'analog']) eq 0) then "V. " else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'analog']) eq 0) then ". " else ()
  )
};

declare function local:xr-association($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'asoc']) eq 0) then "Cf. " else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'asoc']) eq 0) then ". " else ()
  )
};

declare function local:usg($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'syn']) eq 0) then " (" else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'syn']) eq 0) then ")" else ()
  )
};






declare function dlri-views:get-entry-title($entry) {
    let $title := data($entry/tei:form[@type = 'main']/tei:orth)
    
    return if ($title != '') then $title else ' '
};

declare function dlri-views:headword($node) {
	<div class="headword">
		<span>{$entry-title}</span>
	  	<span class="superscript">{data($node/tei:orth/@n)}</span>
	</div>
};

declare function dlri-views:gramGrp($node) {
    <div class="gramGrp">
    	<span>{data($node/tei:pos/@value)}</span>
    	<span>{data($node/tei:iType/@value)}</span>
    	<span>{data($node/tei:subc/@value)}</span>
    	<span>{data($node/tei:gen/@value)}</span>
    </div>
};

declare function dlri-views:sense($node, $current-sense-mark) {
	(
	    <div class="sense-level{concat(count($node/ancestor-or-self::tei:sense), $current-sense-mark)}">
	        {
	            (
	                <span class="sense-level">{data($node/tei:idno[1]/@n)}</span>
	                ,
	                <span>{dlri-views:usg($node/tei:usg)}</span>
	                ,
	                <span>{dlri-views:def($node/tei:def, $node/tei:ptr[@type = 'syn'])}.</span>
	            )
	        }
	    </div>
	    ,
	    <div class="cit-container">
	    	{
	    		(
		            for $cit in $node/tei:cit
		            let $preceding-delimiter := data($cit/preceding-sibling::tei:cit[1]/tei:bibl/@type) || ""
		            let $delimiter := if ($preceding-delimiter != 'cf.') then "Cf." else ""
		            
		            return ($delimiter, dlri-views:cit($cit))
		        )
	        }
	    </div>
	)
};

declare function dlri-views:usg($nodes) {
	let $result :=
		for $usg in $nodes
		return
			let $value := $usg/@value
			
			return
				switch($value)
				case "complementul.indică" return "Complementul indică " || $usg/text()[1]
				default return $value
				
	return if (empty($result)) then () else concat("(", string-join($result, ','), ")")
};

declare function dlri-views:def($definitions, $synonyms) {
	let $definition-content :=
		for $definition in $definitions
		return $definition/text()
	let $synonym-content :=
		for $synonym in $synonyms
		return $synonym/@target
	let $content := ($definition-content, $synonym-content)
		
	return <span>{string-join($content, "; ")}</span>
};

declare function dlri-views:cit($node) {
	let $bibl := $node/tei:bibl
	
	let $quote := dlri-views:bibl-quote(normalize-space($node/tei:quote/text()))
	let $ptr := dlri-views:bibl-ptr(data($bibl/tei:ptr/@target))
	let $date := dlri-views:bibl-date($bibl/tei:date/text() || "")
	let $citedRange := dlri-views:bibl-citedRange($bibl/tei:citedRange/text() || "")
  	let $content :=
		(
			$date
			,
			$ptr
			,
			$citedRange
			,
			$quote
		) 
	let $delimiter := if (ends-with($content[last()]/text(), ".")) then "" else "." 	
  
	return ($content, $delimiter)
};

declare function dlri-views:bibl-quote($content) {
	if (empty($content)) then () else <span class="bibl-quote">: {$content}</span>
};

declare function dlri-views:bibl-ptr($content) {
	if ($content != '') then <span class="bibl-ptr">{substring-after($content, '| ')}</span> else ()
};

declare function dlri-views:bibl-date($content) {
	if ($content != '') then <span class="bibl-date">{$content}</span> else ()
};

declare function dlri-views:bibl-citedRange($content) {
    if ($content != '') then concat(', ', $content) else ()
};

declare function dlri-views:grammatical-information($node) {
	let $type := $node/tei:idno[1]/@type
	
	return
	    <div class="grammatical-information">
	    	{
				switch($type)
				case "grammatical-information-type-for-vb"
				return concat($node/tei:form/tei:tns/@value, ' ', $node/tei:form/tei:mood/@value)
				default return ()   	
	    	}
	    	<span>: {$node/tei:form/tei:form/text()}</span>
	    </div>
};

declare function dlri-views:etym($node) {
	let $language-code := data($node/tei:term[1]/@xml:lang)
	let $language := data($language-codes//html:option[@xml:id = $language-code]/@label)
		
	return
	    <div class="etym">
	    	{
				if (starts-with($node/tei:idno[1]/@type, 'cuvântul.titlu-element.extern'))
				then
					(
						<span>− Din</span>
						,
						<span class="lang">{$language}</span>
						,
						<span class="term">{$node/tei:term[1]/text()}</span>
						,
						<span>.</span>
					)
				else ()    	
	    	}
	    </div>
};

(
    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "resources/css/html.css&quot;")}
    ,
    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "views/oxygen-render.css&quot;")}
    ,    
    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "views/render-entry.css&quot;")}
    ,
    <html>
        <head>
            <title>{$entry-title}</title>
        </head>
        <body>
            {
            	dlri-views:headword($entry/tei:form[@type = 'main'])
            	,
            	dlri-views:gramGrp($entry/tei:gramGrp)
            	,
            	dlri-views:sense($entry/tei:sense[1], "-first")
            	,
            	for $sense in $entry/tei:sense[position() > 1]
            	return dlri-views:sense($sense, "")
            	,
            	for $grammatical-information in $entry/tei:form[@type = 'grammatical-information']
            	return dlri-views:grammatical-information($grammatical-information)
            	,
            	for $etym in $entry/tei:etym
            	return dlri-views:etym($etym)
            }     
        </body>
    </html>
)
