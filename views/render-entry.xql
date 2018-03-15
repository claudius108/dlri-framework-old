xquery version "3.0";

declare namespace file = "http://expath.org/ns/file";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace dlri-views = "http://dlri.ro/ns/dlri-views";
declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace html = "http://www.w3.org/1999/xhtml";

declare variable $frameworkDir external;
declare variable $entry := /*//tei:entry;
declare variable $entry-title := dlri-views:get-entry-title($entry);
declare variable $language-codes := parse-xml(unparsed-text("resources/ontology/languages.html"));
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

declare function dlri-views:sense($node) {
	let $sense-level := data($node/@n)
	let $sense-usg := dlri-views:usg($node/tei:usg)
	let $sense-level-type := if (matches($sense-level, "[A-Z]")) then "block" else "inline"
	let $semantic-units := $node/tei:form[@type = 'unitate-semantică-subsumată']
	
	return
		(
		    <div class="sense-level-{$sense-level-type}">
		        {
		            (
		                local:generate-span($sense-level, "sense-level")
		                ,
		                if (count($semantic-units) > 0)
		                then
		                	for $semantic-unit in $semantic-units
		                	
		                	return local:generate-span($semantic-unit/tei:term[1] || " =", "semantic-unit")
		                else ''
		                ,
		                local:generate-span(string-join(($sense-usg, dlri-views:def($node/tei:def, $node/tei:ptr[@type = 'syn'])), ""), "")
						,
			            for $cit in $node/tei:cit[normalize-space(string-join(.//* | .//tei:ptr/@target[. != 'unknown'])) != '']
			            let $preceding-type := data($cit/preceding-sibling::tei:cit[1]/tei:bibl/@type)
			            let $current-type := data($cit/tei:bibl/@type)
			            
			            let $delimiter-1 := if ($current-type = 'unknown') then "" else $current-type
			            let $delimiter-2 := if ($delimiter-1 = 'cf.') then "Cf." else $delimiter-1
			            let $delimiter-3 := if ($preceding-type = 'cf.') then "" else $delimiter-2
			            
			            return
							<div class="cit-container">
								{
									($delimiter-3, dlri-views:cit($cit))
								}
							</div>
						,
						if ($sense-level-type = 'block')
						then dlri-views:sense($node/tei:sense[1])
						else
						    for $sense in $node/tei:sense
						    return dlri-views:sense($sense)						
					)
				}		        
		    </div>
		    ,
			if ($sense-level-type = 'block')
			then
			    for $sense in $node/tei:sense[position() > 1]
			    return dlri-views:sense($sense)			
			else ()
		)
};

declare function dlri-views:usg($nodes) {
	let $result :=
		for $usg in $nodes
		return
			let $usg-value := $usg/@value
			let $processed-usg-value-1 :=
				switch($usg-value)
				case "complementul.indică" return "Complementul indică"
				default return $usg-value
			let $processed-usg-value-2 := replace($processed-usg-value-1, "\.\.", " ")
			let $processed-usg-value-3 := replace($processed-usg-value-2, "\.", " ")
							
			return $processed-usg-value-3 || " " || $usg/text()[1]

				
	return if (empty($result)) then () else concat("(", string-join($result, ', '), ") ")
};

declare function dlri-views:def($definitions, $synonyms) {
	let $definition-content :=
		for $definition in $definitions
		return $definition/text()
	let $synonym-content :=
		for $synonym in $synonyms
		return $synonym/@target
	let $content-1 := ($definition-content, $synonym-content)
	let $content-2 := if (empty($content-1)) then () else string-join($content-1, "; ")
		
	return $content-2
};

declare function dlri-views:cit($node) {
	let $bibl := $node/tei:bibl
	
	let $date := local:generate-span(data($bibl/tei:date), "bibl-date")
	
	let $ptr := data($bibl/tei:ptr/@target)
	let $ptr-processed := local:generate-span(if ($ptr != 'unknown') then substring-after($ptr, '| ') else '', "bibl-ptr")	
	
	let $citedRange := local:generate-span(data($bibl/tei:citedRange), "")
	
	let $quote := data($node/tei:quote)
	let $quote-processed := local:generate-span(if ($quote != '') then ": " || $quote else '', "bibl-quote")
	
	return ($date, $ptr-processed, $citedRange, $quote-processed)
};

declare function dlri-views:writing-form($node) {
    <div class="writing-form">− Scris și: {$node/tei:oVar/text()}.</div>
};

declare function dlri-views:abbreviation-form($node) {
    <div class="abbreviation-form">Abr.: {$node/tei:abbr/text()}.</div>
};

declare function dlri-views:accentuation-form($node) {
	<div class="accentuation-form">Accentuat și: {dlri-views:usg($node/tei:usg)} {$node/tei:stress/text()}.</div>
};

declare function dlri-views:articulation-form($node) {
	<div class="articulation-form">Articulat: {$node/tei:term/text()}.</div>
};

declare function dlri-views:pronunciation-form($node) {
    <div class="pronunciation-form">− Pronunțat: {$node/tei:pRef/text()}.</div>
};
declare function dlri-views:grammatical-information($node) {
	let $type := $node/tei:form[1]/@type
	
	return
	    <div class="grammatical-information">
	    	{
	    		distinct-values(
					switch($type)
					case "grammatical-information-for-verb"
					return
						for $term in $node/tei:form
						let $sense-number := if ($term/@corresp != '') then concat(' (', $term/@corresp, ')') else ''
						
						return concat($term/tei:tns/@value, ' ', $term/tei:mood/@value, $sense-number)
					case "grammatical-information-for-plural"
					return "− Pl."
					default return ()
				)   	
	    	}
	    	<span>: {string-join($node/tei:form/tei:form, ", ")}.</span>
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
        <title>&#65279;</title>
        <meta charset="utf-8" />
		<style type="text/css">{unparsed-text("views/render-entry.css")}</style>        
    </head>
    <body>
    	<button onclick="refreshContent();"><img src="resources/circular-arrow-yang.png" /></button>
        {
        	dlri-views:headword($entry/tei:form[@type = 'headword'])
        	,
        	dlri-views:gramGrp($entry/tei:gramGrp)
        	,
        	let $senses := $entry/tei:dictScrap[@xml:id = $processed-editing-mode || '-senses']/tei:sense
        	
        	return
	        	for $sense in $senses
	        	return dlri-views:sense($sense)
        	,
        	for $form in $entry/tei:form[@type = 'accentuation-variant']
        	return dlri-views:accentuation-form($form)
        	,
        	for $form in $entry/tei:form[@type = 'articulation']
        	return dlri-views:articulation-form($form)        	
        	,        	
        	for $pronunciation-form in $entry/tei:form[@type = 'pronunciation']
        	return dlri-views:pronunciation-form($pronunciation-form)
        	,
        	for $writing-form in $entry/tei:form[@type = 'writing']
        	return dlri-views:writing-form($writing-form)
        	,
        	for $abbreviation-form in $entry/tei:form[@type = 'abbreviation']
        	return dlri-views:abbreviation-form($abbreviation-form)
        	,        	
        	for $grammatical-information in $entry/tei:form[@type = 'grammatical-information']
        	return dlri-views:grammatical-information($grammatical-information)
        	,
        	dlri-views:etym($entry/tei:etym)
        }
        <script type="text/javascript" src="resources/render-entry.js">/**/</script>     
    </body>
</html>
