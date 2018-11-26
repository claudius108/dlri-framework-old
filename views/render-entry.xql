xquery version "3.0";

declare namespace file = "http://expath.org/ns/file";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace dlr-views = "http://lingv.ro/ns/dlr-views";
declare namespace dlr-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace html = "http://www.w3.org/1999/xhtml";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:version "5.0";
declare option output:item-separator "";

declare variable $frameworkDir external;
declare variable $entry := /*//tei:entry;
declare variable $entry-title := dlr-views:get-entry-title($entry);
declare variable $language-codes := parse-xml(unparsed-text("resources/ontology/languages.html"));
declare variable $usages := parse-xml(unparsed-text("resources/ontology/usages-types.html"));

declare variable $editing-mode := replace(/*//tei:text/@type, "editing-mode-", "");
declare variable $rendering-mode := "online"; (: "print" :)

declare function local:generate-span($content, $class-name) {
  	if ($content != '')
  	then 
  		<span>
  			{
  				(
  					if ($class-name != '') then attribute class {$class-name} else ()
  					,
  					$content
  				)
  			}
  		</span>
	else ""
					

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

declare function dlr-views:get-entry-title($entry) {
    let $title := data($entry/tei:form[@type = 'headword']/tei:orth)
    
    return if ($title != '') then $title else ''
};

declare function dlr-views:headword($node) {
	<div class="headword">
		<span>{$entry-title}</span>
	  	{local:generate-span(data($node/tei:orth/@n), "superscript")}
	  	<span>, </span>
	</div>
};

declare function dlr-views:gramGrp($node) {
	if (not(empty($node)))
	then
	    <div class="gramGrp">
	    	{
		   		string-join($node/(tei:pos/@value, tei:iType/@value, tei:subc/@value, tei:gen/@value), " ")
	    	}
	    </div>
	else ()
};

declare function dlr-views:sense($node) {
	let $sense-level := data($node/@n)
	let $sense-usg := dlr-views:usg-with-parenthesis($node/tei:def[1]/preceding-sibling::tei:usg)
	let $sense-level-type :=
		if ($rendering-mode = 'online')
		then "block"
		else if (matches($sense-level, "[A-Z]")) then "block" else "inline"
	let $semantic-units-1 := $node/tei:form[@type = 'unitate-semantică-subsumată']
	let $semantic-units-2 := 
		if (count($semantic-units-1) > 0)
		then dlr-views:semantic-unit($semantic-units-1)
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
		                dlr-views:def($node/tei:def)
		                ,
		                "."
						,
			            for $cit in $node/tei:cit[normalize-space(string-join(.//* | .//tei:ptr/@target[. != 'unknown'])) != '']
			            let $preceding-type := data($cit/preceding-sibling::tei:cit[1]/tei:bibl/@type)
			            let $current-type := data($cit/tei:bibl/@type)
			            
			            let $prefix-1 := if ($current-type = 'unknown') then "" else $current-type
			            let $prefix-2 := if ($prefix-1 = 'cf.') then "Cf. " else $prefix-1
			            let $prefix-3 := if ($preceding-type = 'cf.') then "" else $prefix-2
			            let $sufix := if ($cit/following-sibling::tei:cit) then ", " else ""
			            
			            return
							<div class="cit-container-{$sense-level-type}">
								{
									($prefix-3, dlr-views:cit($cit), $sufix)
								}
							</div>
						,
						if ($rendering-mode = 'online')
						then ()
						else
							if ($sense-level-type = 'block')
							then dlr-views:sense($node/tei:sense[1])
							else
							    for $sense in $node/tei:sense
							    return dlr-views:sense($sense)
					)
				}		        
		    </div>
		    ,
		    if ($rendering-mode = 'online')
		    then
				for $sense in $node/tei:sense
				return dlr-views:sense($sense)		    
		    else
				if ($sense-level-type = 'block')
				then
				    for $sense in $node/tei:sense[position() > 1]
				    return dlr-views:sense($sense)			
				else ()
		)
};

declare function dlr-views:usg($nodes) {
	if (not(empty($nodes)))
	then
		let $result :=
			for $node in $nodes
			
			return
				let $usg-value := $node/@value
				let $usg-label := $usages//html:option[@value = $usg-value]/@label
				
				let $delimiter := $node/@rend/string()
				let $delimiter-1 := if ($delimiter != '') then $delimiter else ', '
				let $delimiter-2 := if ($delimiter-1 = 'și') then concat(' ', $delimiter, ' ') else $delimiter
								
				return $usg-label || " " || $node/text()[1] || $delimiter-2
				
		return string-join($result, '')
	else ()
};

declare function dlr-views:usg-with-parenthesis($nodes) {
	let $usg := dlr-views:usg($nodes)
	
	return if (not(empty($usg))) then concat(" (", $usg, ")") else ()
};

declare function dlr-views:semantic-unit($nodes) {
	let $result :=
		for $node in $nodes
		let $type := $node/tei:idno/@type
		let $prefix :=
			switch($type)
			case "syntagma" return " Sint."
			default return ""

		return ($prefix, " ", local:generate-span($node/tei:term[1]/text(), "bold"), " | ")
	let $definitions := $nodes/following-sibling::tei:def/text()
	let $sufix := if ($definitions != '') then " =" else ""	
		
	
	return ($result[position() < last()], $sufix) 
};

declare function dlr-views:def($nodes) {
	let $result :=
		for $node in $nodes
		let $corresp-value := concat('#', $node/@xml:id)
		let $usages-content := dlr-views:usg-with-parenthesis($node/following-sibling::tei:usg[@corresp = $corresp-value])
		let $references-content :=
			for $reference in $node/following-sibling::tei:ptr[@type = ('syn', 'analog', 'asoc', 'antonim') and @corresp = $corresp-value]
			
			return $reference/@target
		let $content-1 := string-join(($usages-content, $node/text(), $references-content), "")
			
		
		return (
			$content-1
			,
			dlr-views:latin-name($node/following-sibling::tei:term[@corresp = $corresp-value])
			,
			"; "
		)
		
	return $result[position() < last()]
};

declare function dlr-views:latin-name($node) {
	let $result := $node/text()
	
	return
		if ($result != '')
		then ("(", local:generate-span($result, "italic"), ")")
		else ""
};

declare function dlr-views:cit($node) {
	let $quote := data($node/tei:quote)
	let $quote-processed := local:generate-span(if ($quote != '') then ": " || $quote else '', "")
	
	return (dlr-views:bibl($node/tei:bibl), $quote-processed)
};

declare function dlr-views:bibl($node) {
	let $result :=
		let $date := local:generate-span(data($node/tei:date), "bold")
		
		let $ptr-1 := data($node/tei:ptr/@target)
		let $ptr-2 := local:generate-span(if ($ptr-1 != 'unknown') then substring-after($ptr-1, '| ') else '', "bibl-ptr")	
		let $citedRange-1 := $node/tei:citedRange
		let $citedRange-2 := if ($citedRange-1 != '') then local:generate-span(', ' || $citedRange-1, "") else ''
		
		return ($date, $ptr-2, $citedRange-2)

	return $result
};

declare function dlr-views:bibl-with-parenthesis($nodes) {
	if (empty($nodes)) then "" else (" (", dlr-views:bibl($nodes), ")")
};

declare function dlr-views:abbreviation-form($node) {
    <div class="abbreviation-form">Abr.: {$node/tei:abbr/text()}.</div>
};

declare function dlr-views:accentuation-form($node) {
	<div class="accentuation-form">– Accentuat și: {dlr-views:usg-with-parenthesis($node/tei:usg)} {local:generate-span($node/tei:stress/text(), "italic")} {dlr-views:bibl-with-parenthesis($node/tei:bibl)}.</div>
};

declare function dlr-views:articulation-form($node) {
	<div class="articulation-form">– Articulat: {$node/tei:term/text()}.</div>
};

declare function dlr-views:pronunciation-form($node) {
    <div class="pronunciation-form">− Pronunțat: {$node/tei:pRef/text()}.</div>
};

declare function dlr-views:writing-form($node) {
    <div class="writing-form">− Scris și: {dlr-views:usg-with-parenthesis($node/tei:usg)} {$node/tei:oVar/text()}.</div>
};

declare function dlr-views:grammatical-information($node) {
	let $type := $node/tei:form[1]/@type
	
	return
	    <div class="grammatical-information">
	    	{
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
						let $usg := dlr-views:usg($form/tei:usg)
						let $gramGrp := dlr-views:gramGrp($form/tei:gramGrp)
						let $prefix :=
							if (empty($usg) and empty($gramGrp))
							then ()
							else ("(", $usg, ", ", $gramGrp, ")")
						
						return ($prefix, " ", local:generate-span($form/tei:number, "italic"), " și ")
					
					return ("− Pl.: ", $forms[position() < last()], ".") 
				default return ()
	    	}
	    </div>
};

declare function dlr-views:lexical-variant($nodes) {
	let $result :=
		for $node at $i in $nodes
		let $current-gramGrp := dlr-views:gramGrp($node/tei:gramGrp)
		let $next-gramGrp := dlr-views:gramGrp($nodes[$i + 1]/tei:gramGrp)
		
		return (
			dlr-views:usg-with-parenthesis($node/tei:usg)
			,
			" "
			,
			$node/tei:def/text()
			,
			dlr-views:bibl-with-parenthesis($node/tei:bibl)
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

declare function dlr-views:etym($nodes) {
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
        <title>ILIR</title>
        <meta charset="utf-8" />
        <base href="file:///{$frameworkDir}/" />
		<link rel="stylesheet" href="views/render-entry.css" />
    </head>
    <body>
    	<button onclick="refreshContent();"><img src="resources/images/circular-arrow-yang.png" /></button>
        {
        	dlr-views:headword($entry/tei:form[@type = 'headword'])
        	,
        	dlr-views:gramGrp($entry/tei:gramGrp)
        	,
        	let $senses := $entry/tei:dictScrap[@xml:id = $editing-mode || '-senses']/tei:sense
        	
        	return
	        	for $sense in $senses
	        	return dlr-views:sense($sense)
        	,
        	for $form in $entry/tei:form[@type = 'accentuation-variant']
        	return dlr-views:accentuation-form($form)
        	,
        	for $form in $entry/tei:form[@type = 'articulation']
        	return dlr-views:articulation-form($form)        	
        	,        	
        	for $form in $entry/tei:form[@type = 'pronunciation']
        	return dlr-views:pronunciation-form($form)
        	,
        	for $form in $entry/tei:form[@type = 'writing']
        	return dlr-views:writing-form($form)
        	,
        	for $form in $entry/tei:form[@type = 'abbreviation']
        	return dlr-views:abbreviation-form($form)
        	,        	
        	for $form in $entry/tei:form[@type = 'grammatical-information']
        	return dlr-views:grammatical-information($form)
        	,
        	dlr-views:lexical-variant($entry/tei:re[@type = 'lexical-variant-section'])        	
        	,
        	dlr-views:etym($entry/tei:etym)
        }
        <script type="text/javascript" src="views/render-entry.js">/**/</script>
    </body>
</html>
