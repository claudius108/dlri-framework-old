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
declare variable $usages := parse-xml(unparsed-text("resources/ontology/usages.html"));

declare variable $editing-mode := replace(/*//tei:text/@type, "editing-mode-", "");

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
	let $semantic-units-1 := $node/tei:form[@type = 'unitate-semantică-subsumată']
	let $semantic-units-2 := 
		if (count($semantic-units-1) > 0)
		then dlri-views:semantic-unit($semantic-units-1)
		else ''
	
	return
		(
		    <div class="sense-level-{$sense-level-type}">
		        {
		            (
		                local:generate-span($sense-level, "sense-level")
		                ,
		                $semantic-units-2
		                ,
		                local:generate-span($sense-usg, "")
		                ,
		                dlri-views:def($node/tei:def)
		                ,
		                "."
						,
			            for $cit in $node/tei:cit[normalize-space(string-join(.//* | .//tei:ptr/@target[. != 'unknown'])) != '']
			            let $preceding-type := data($cit/preceding-sibling::tei:cit[1]/tei:bibl/@type)
			            let $current-type := data($cit/tei:bibl/@type)
			            
			            let $prefix-1 := if ($current-type = 'unknown') then "" else $current-type
			            let $prefix-2 := if ($prefix-1 = 'cf.') then "Cf." else $prefix-1
			            let $prefix-3 := if ($preceding-type = 'cf.') then "" else $prefix-2
			            let $sufix := if ($cit/following-sibling::tei:cit) then ", " else ""
			            
			            return
							<div class="cit-container">
								{
									($prefix-3, dlri-views:cit($cit), $sufix)
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
			let $usg-label := $usages//html:option[@value = $usg-value]/@label
			
			let $delimiter := $node/tei:pc/text()
			let $delimiter-1 := if ($delimiter != '') then $delimiter else ', '
			let $delimiter-2 := if ($delimiter-1 = 'și') then concat(' ', $delimiter, ' ') else $delimiter
							
			return $usg-label || " " || $node/text()[1] || $delimiter-2

				
	return if (empty($result)) then () else concat("(", string-join($result, ''), ") ")
};

declare function dlri-views:semantic-unit($nodes) {
	let $result :=
		for $node in $nodes
		let $type := $node/tei:idno/@type
		let $prefix :=
			switch($type)
			case "syntagma" return "Sint."
			default return ""

		return ($prefix, local:generate-span($node/tei:term[1]/text(), "bold"), " | ")
	let $definitions := $nodes/following-sibling::tei:def/text()
	let $sufix := if ($definitions != '') then "=" else ""	
		
	
	return ($result[position() < last()], $sufix) 
};

declare function dlri-views:def($nodes) {
	let $result :=
		for $node in $nodes
		let $corresp-value := concat('#', $node/@xml:id)
		let $references-content :=
			for $reference in $node/following-sibling::tei:ptr[@type = ('syn', 'analog', 'asoc', 'antonim') and @corresp = $corresp-value]
			
			return $reference/@target
		let $content-1 := string-join(($node/text(), $references-content), "")
			
		
		return (
			$content-1
			,
			dlri-views:latin-name($node/following-sibling::tei:term[@corresp = $corresp-value])
			,
			"; "
		)
		
	return $result[position() < last()]
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
	let $quote-processed := local:generate-span(if ($quote != '') then ": " || $quote else '', "")
	
	return (dlri-views:bibl($node/tei:bibl), $quote-processed)
};

declare function dlri-views:bibl($node) {
	let $result :=
		let $date := local:generate-span(data($node/tei:date), "bold")
		
		let $ptr-1 := data($node/tei:ptr/@target)
		let $ptr-2 := local:generate-span(if ($ptr-1 != 'unknown') then substring-after($ptr-1, '| ') else '', "bibl-ptr")	
		let $citedRange-1 := $node/tei:citedRange
		let $citedRange-2 := if ($citedRange-1 != '') then local:generate-span(', ' || $citedRange-1, "") else ''
		
		return ($date, $ptr-2, $citedRange-2)

	return
		if (empty($result))
		then ""
		else $result
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
					return
						let $forms :=
							for $form in $node/tei:form
							let $usg-1 := dlri-views:usg($form/tei:usg)
							let $usg-2 := replace($usg-1, "\(", "")
							let $usg-3 := replace($usg-2, "\)", "")
							let $gramGrp := dlri-views:gramGrp($form/tei:gramGrp)
							let $secondary-content :=
								if (string-length(string-join(($usg-3, $gramGrp), '')) = 1)
								then ""
								else ("(", $usg-3, $gramGrp, ", ", ")")
							
							return ($secondary-content, $form/tei:number/text(), " și ")
						
						return ("− Pl.", $forms[position() < last()]) 
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
        	let $senses := $entry/tei:dictScrap[@xml:id = $editing-mode || '-senses']/tei:sense
        	
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
