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
	()
};

declare function local:xr-synonym($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'syn']) eq 0) then ";" else ", ",
    if (count($node/following-sibling::tei:xr[@type = 'syn']) eq 0) then ". " else ()
  )
};

declare function local:xr-analogy($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'analog']) eq 0) then "V. " else ", ",
    if (count($node/following-sibling::tei:xr[@type = 'analog']) eq 0) then ". " else ()
  )
};

declare function local:xr-association($node) {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'asoc']) eq 0) then "Cf. " else ", ",
    if (count($node/following-sibling::tei:xr[@type = 'asoc']) eq 0) then ". " else ()
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
		                then local:generate-span(dlri-views:semantic-unit($semantic-units), "semantic-unit")
		                else ''
		                ,
		                local:generate-span($sense-usg, "")
		                ,
		                for $def in $node/tei:def
		                let $corresp-value := concat('#', $def/@xml:id)
		                
		                return (
		                	local:generate-span(string-join((dlri-views:def($def, $def/following-sibling::tei:ptr[@type = ('syn', 'analog', 'asoc', 'antonim') and @corresp = $corresp-value])), ""), "")
		                	,
		                	dlri-views:latin-name($def/following-sibling::tei:term[@corresp = $corresp-value])
		                )
		                ,
		                "."
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
		for $node in $nodes
		
		return
			let $usg-value := $node/@value
			let $processed-usg-value-1 :=
				switch($usg-value)
				case "complementul.indică" return "Complementul indică"
				default return $usg-value
			let $processed-usg-value-2 := replace($processed-usg-value-1, "\.\.", " ")
			let $processed-usg-value-3 := replace($processed-usg-value-2, "\.", " ")
							
			return $processed-usg-value-3 || " " || $node/text()[1]

				
	return if (empty($result)) then () else concat("(", string-join($result, ', '), ") ")
};

declare function dlri-views:semantic-unit($nodes) {
	let $processed-semantic-units :=
		for $node in $nodes
		
		return $node/tei:term[1]
	
	return string-join($processed-semantic-units, " | ")
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

declare function dlri-views:latin-name($node) {
	let $result := $node/text()
	
	return
		if ($result != '')
		then ("(", local:generate-span($result, "italic"), ")")
		else ""
};

declare function dlri-views:cit($node) {
	let $quote := data($node/tei:quote)
	let $quote-processed := local:generate-span(if ($quote != '') then ": " || $quote else '', "bibl-quote")
	
	return (dlri-views:bibl($node/tei:bibl), $quote-processed)
};

declare function dlri-views:bibl($nodes) {
	let $result :=
		for $node in $nodes
		
		return	
			let $date := local:generate-span(data($node/tei:date), "bibl-date")
			
			let $ptr := data($node/tei:ptr/@target)
			let $ptr-processed := local:generate-span(if ($ptr != 'unknown') then substring-after($ptr, '| ') else '', "bibl-ptr")	
			
			let $citedRange := local:generate-span(data($node/tei:citedRange), "")
			
			return ($date, $ptr-processed, $citedRange, ", ")

	return
		if (empty($result))
		then ()
		else $result[position() < last()]
};

declare function dlri-views:bibl-with-parenthesis($nodes) {
	let $bibl := dlri-views:bibl($nodes)[. != "&#65279;"]
	let $bibl-processed := if ($bibl != "") then (" (", $bibl, ")") else ""
	
	return $bibl-processed
};

declare function dlri-views:abbreviation-form($node) {
    <div class="abbreviation-form">Abr.: {$node/tei:abbr/text()}.</div>
};

declare function dlri-views:accentuation-form($node) {
	<div class="accentuation-form">– Accentuat și: {dlri-views:usg($node/tei:usg)} {local:generate-span($node/tei:stress/text(), "italic")} {dlri-views:bibl-with-parenthesis($node/tei:bibl)}.</div>
};

declare function dlri-views:articulation-form($node) {
	<div class="articulation-form">– Articulat: {$node/tei:term/text()}.</div>
};

declare function dlri-views:pronunciation-form($node) {
    <div class="pronunciation-form">− Pronunțat: {$node/tei:pRef/text()}.</div>
};

declare function dlri-views:writing-form($node) {
    <div class="writing-form">− Scris și: {dlri-views:usg($node/tei:usg)}  {$node/tei:oVar/text()}.</div>
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

declare function dlri-views:lexical-variant($nodes) {
	let $result :=
		for $node at $i in $nodes
		let $current-gramGrp := dlri-views:gramGrp($node/tei:gramGrp)
		let $next-gramGrp := dlri-views:gramGrp($nodes[$i + 1]/tei:gramGrp)
		
		return (
			dlri-views:usg($node/tei:usg)
			,
			$node/tei:def/text()
			,
			dlri-views:bibl-with-parenthesis($node/tei:bibl)
			,
			if ($current-gramGrp != $next-gramGrp) then $current-gramGrp else ""
			,
			", "			
		)	
	
	return
		if (empty($result))
		then ()
		else	
			<div class="lexical-variant">
				{
					"– Şi: "
					,
					$result[position() < last()]
					,
					if (ends-with($result[position() < (last() - 1)][last()], ".")) then "" else "."
				}
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
        <base href="file:///{$frameworkDir}/" />
		<link rel="stylesheet" href="views/render-entry.css" />
    </head>
    <body>
    	<button onclick="refreshContent();"><img src="resources/images/circular-arrow-yang.png" /></button>
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
        	for $form in $entry/tei:form[@type = 'pronunciation']
        	return dlri-views:pronunciation-form($form)
        	,
        	for $form in $entry/tei:form[@type = 'writing']
        	return dlri-views:writing-form($form)
        	,
        	for $form in $entry/tei:form[@type = 'abbreviation']
        	return dlri-views:abbreviation-form($form)
        	,        	
        	for $form in $entry/tei:form[@type = 'grammatical-information']
        	return dlri-views:grammatical-information($form)
        	,
        	dlri-views:lexical-variant($entry/tei:re[@type = 'lexical-variant-section'])        	
        	,
        	dlri-views:etym($entry/tei:etym)
        }
        <script type="text/javascript" src="views/render-entry.js">/**/</script>
    </body>
</html>
