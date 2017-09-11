xquery version "3.0";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace dlri-views = "http://dlri.ro/ns/dlri-views";
declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace html = "http://www.w3.org/1999/xhtml";

declare variable $frameworkDir external;
declare variable $entry := /*//tei:entry;
declare variable $entry-title := dlri-views:get-entry-title($entry);
declare variable $language-codes := doc($frameworkDir || "/resources/ontology/languages.html");
declare variable $editing-mode := /*//tei:text/@type/data(.);
declare variable $processed-editing-mode := replace($editing-mode, "editing-mode-", "");

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

declare function local:generate-span($content, $class-name) {
  	if ($content != '')
  	then (
		"&#65279;"
		,				  	
  		<span>
  			{
  				(
  					if ($class-name != '') then attribute class {$class-name} else ()
  					,
  					$content
  				)
  			}
  		</span>
	  	,
	  	"&#65279;"
	)
	else "&#65279;"
					

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
    let $title := data($entry/tei:form[@type = 'headword']/tei:orth)
    
    return if ($title != '') then $title else ''
};

declare function dlri-views:headword($node) {
	<div class="headword">
		<span>{$entry-title}</span>
	  	{local:generate-span(data($node/tei:orth/@n), "superscript")}
	  	<span>, </span>
	</div>
};

declare function dlri-views:gramGrp($node) {
    <div class="gramGrp">
    	{
	   		local:generate-span(string-join($node/(tei:pos/@value, tei:iType/@value, tei:subc/@value, tei:gen/@value), " "), "")
    	}
    </div>
};

declare function dlri-views:sense($node, $current-sense-mark) {
	let $sense-level := data($node/tei:idno[1]/@n)
	let $sense-usg := dlri-views:usg($node/tei:usg)
	
	return
		(
		    <div class="sense-level{concat(count($node/ancestor-or-self::tei:sense), $current-sense-mark)}">
		        {
		            (
		                if ($sense-level != '') then <span class="sense-level">{$sense-level}</span> else ()
		                ,
		                if ($sense-usg != '') then <span>{$sense-usg}</span> else ()
		                ,
		                <span>{dlri-views:def($node/tei:def, $node/tei:ptr[@type = 'syn'])}</span>
		            )
		        }
				{
			            for $cit in $node/tei:cit[normalize-space(string-join(.//* | .//tei:ptr/@target[. != 'unknown'])) != '']
			            let $preceding-type := data($cit/preceding-sibling::tei:cit[1]/tei:bibl/@type)
			            let $current-type := data($cit/tei:bibl/@type)
			            let $delimiter := if ($preceding-type != 'cf.') then "Cf." else ""
			            let $delimiter := if ($current-type = 'unknown') then "" else $current-type
			            
			            return
							<div class="cit-container">
								{
									($delimiter, dlri-views:cit($cit))
								}
							</div>
				}		        
		    </div>
		    ,
		    for $sense in $node/tei:sense
		    return dlri-views:sense($sense, "")
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
	let $content-1 := ($definition-content, $synonym-content)
	let $content-2 := if (empty($content-1)) then () else <span>{string-join($content-1, "; ")}</span>
		
	return $content-2
};

declare function dlri-views:cit($node) {
	let $bibl := $node/tei:bibl
	
	let $date := local:generate-span(data($bibl/tei:date), "bibl-date")
	
	let $ptr := data($bibl/tei:ptr/@target)
	let $ptr-processed := local:generate-span(if ($ptr != 'unknown') then $ptr else '', "bibl-ptr")	
	
	let $citedRange := local:generate-span(data($bibl/tei:citedRange), "")
	
	let $quote := data($node/tei:quote)
	let $quote-processed := local:generate-span(if ($quote != '') then ": " || $quote else '', "bibl-quote")
	
	return ($date, $ptr-processed, $citedRange, $quote-processed)
};

declare function dlri-views:bibl-citedRange($content) {
    if ($content != '') then concat(', ', $content) else ()
};

declare function dlri-views:writing-form($node) {
    <div class="writing-form">− Scris și: {$node/tei:oVar/text()}.</div>
};

declare function dlri-views:pronunciation-form($node) {
    <div class="pronunciation-form">− Pronunțat: {$node/(tei:pRef | tei:syll)/text()}.</div>
};
declare function dlri-views:grammatical-information($node) {
	let $type := $node/tei:form/@type
	
	return
	    <div class="grammatical-information">
	    	{
				switch($type)
				case "grammatical-information-for-verb"
				return concat($node/tei:form/tei:tns/@value, ' ', $node/tei:form/tei:mood/@value)
				case "grammatical-information-for-plural"
				return "− Pl."
				default return ()   	
	    	}
	    	<span>: {normalize-space($node/tei:form/string())}.</span>
	    </div>
};

declare function dlri-views:etym($nodes) {
    <div class="etym">
    	{
    		(
				for $node in $nodes
				
				return
					let $language-code := data($node/tei:term[1]/@xml:lang)
					let $language := data($language-codes//html:option[@value = $language-code]/@label)
						
					return
			
					    		(
									if (starts-with($node/tei:idno[1]/@type, 'cuvântul.titlu-element.extern'))
									then
										(
											<span>− Din</span>
											,
											<span class="lang">{$language}</span>
											,
											<span class="term">{$node/tei:term[1]/text()}</span>
										)
									else ()
									,
									if ($node/tei:idno[1]/@type = 'cuvântul.titlu-element.moştenit-etimon.atestat')
									then
										(
											", "
											,
											<span class="lang">{$language}</span>											
											,
											<span class="term">{$node/tei:term[1]/text()}</span>
										)
									else ()
								)
				,
				"."
			)
    	}
    </div>
};

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$entry-title}</title>
        <meta charset="utf-8" />
        <link rel="stylesheet" type="text/css" href="resources/render-entry.css" />
    </head>
    <body>
    	<button onclick="refreshContent();"><img src="resources/circular-arrow-yang.png" /></button>
        {
        	dlri-views:headword($entry/tei:form[@type = 'headword'])
        	,
        	dlri-views:gramGrp($entry/tei:gramGrp)
        	,
        	let $senses := $entry/tei:dictScrap[@xml:id = $processed-editing-mode || '-senses']/tei:sense
        	
        	return (
	        	dlri-views:sense($senses[1], "-first")
	        	,
	        	for $sense in $senses[position() > 1]
	        	return dlri-views:sense($sense, "")        	
        	)
        	,
        	for $writing-form in $entry/tei:form[@type = 'writing']
        	return dlri-views:writing-form($writing-form)
        	,   
        	for $pronunciation-form in $entry/tei:form[@type = 'pronunciation']
        	return dlri-views:pronunciation-form($pronunciation-form)
        	,               	         	
        	for $grammatical-information in $entry/tei:form[@type = 'grammatical-information']
        	return dlri-views:grammatical-information($grammatical-information)
        	,
        	dlri-views:etym($entry/tei:etym)
        }
        <script type="text/javascript" src="resources/render-entry.js">/**/</script>     
    </body>
</html>
