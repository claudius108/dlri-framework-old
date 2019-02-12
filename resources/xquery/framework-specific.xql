xquery version "3.0";

declare namespace file = "http://expath.org/ns/file";
declare namespace arch = "http://expath.org/ns/archive";
declare namespace bin = "http://expath.org/ns/binary";

declare namespace skos = "http://www.w3.org/2004/02/skos/core#";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace org = "http://www.w3.org/ns/org#";
declare namespace foaf = "http://xmlns.com/foaf/0.1/";

declare default element namespace "http://www.w3.org/1999/xhtml";

declare variable $pluginInstallDirPath external;
declare variable $frameworkDirPath external;

declare variable $frameworkJavaDirPath := file:path-to-native($frameworkDirPath || "/java");
declare variable $frameworkJarPath := file:path-to-native($frameworkJavaDirPath || "/framework.jar");
declare variable $frameworkId := file:name($frameworkDirPath);
declare variable $frameworkTargetDirPath := file:path-to-native($frameworkDirPath || "/target");
declare variable $frameworkResourcesDirPath := file:path-to-native($frameworkDirPath || "/resources");
declare variable $frameworkUberJarPath := file:path-to-native($frameworkTargetDirPath || "/" || $frameworkId || ".jar");

declare variable $ontology-github-url := "https://rawgit.com/lingv-ro/ilir-ontology/master";
declare variable $charset := "@charset &quot;utf-8&quot;; ";

declare function local:generate-datalist($datalist-name as xs:string, $datalist-labels as xs:string*, $datalist-values as xs:string*, $add-empty-value) {
	let $labels := $datalist-labels ! normalize-space(.)
	let $labels :=
		if ($add-empty-value)
		then ("", $labels)
		else $labels
	let $labels := string-join($labels, ",")
	
	let $values := $datalist-values ! normalize-space(.)
	let $values :=
		if ($add-empty-value)
		then ("", $values)
		else $values
	let $values := string-join($values, ",")
	let $datalist := 
		string-join(
			(
				$charset,
				"&#10;",
				"@" || $datalist-name || "-labels: ",
				"&quot;" || $labels || "&quot;",
				";",
				"&#10;",
				"@" || normalize-space($datalist-name) || "-values: ",
				"&quot;" || $values || "&quot;",
				";"
			),
			""
		)
	
		
	return (
		file:write-text($frameworkResourcesDirPath || "/css/datalists/" || $datalist-name || ".less", $datalist)
		,
		file:write-binary(
			$frameworkUberJarPath,	
			arch:update(
				file:read-binary($frameworkUberJarPath),
				"resources/css/datalists/" || $datalist-name || ".less",
				bin:encode-string($datalist)
			)
		)		
	)
};

(: process the controlled vocabulary for etymology types :)
let $etymology-types := parse-xml(unparsed-text($ontology-github-url || "/etymology-types.rdf"))
let $headword-etymology-types-concepts := $etymology-types//skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/etymology/types/headword']//skos:Concept
let $sense-etymology-types-concepts := $etymology-types//skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/etymology/types/sense']//skos:Concept
let $variant-etymology-types-concepts := $etymology-types//skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/etymology/types/variant']//skos:Concept
let $etymological-note-types-concepts := parse-xml(unparsed-text($ontology-github-url || "/etymological-note-types.rdf"))//skos:Concept
let $languages-concepts := parse-xml(unparsed-text($ontology-github-url || "/languages.rdf"))//skos:Concept
let $usages-types-concepts := parse-xml(unparsed-text($ontology-github-url || "/usages-types.rdf"))//skos:Concept
let $semantic-units-concepts := parse-xml(unparsed-text($ontology-github-url || "/semantic-units.rdf"))//skos:OrderedCollection[1]//skos:Concept
let $members-doc := parse-xml(unparsed-text($ontology-github-url || "/members.rdf"))
let $redactors-concepts := $members-doc//skos:Concept[ends-with(foaf:Person/org:Membership/@rdf:resource, 'dlr-redactors')]
let $redactors-concepts :=
	for $redactors-concept in $redactors-concepts
	order by $redactors-concept/foaf:Person/foaf:name
	
	return $redactors-concept
let $editors-concepts := $members-doc//skos:Concept[ends-with(foaf:Person/org:Membership/@rdf:resource, 'dlr-editors')]
let $editors-concepts :=
	for $editors-concept in $editors-concepts
	order by $editors-concept/foaf:Person/foaf:name
	
	return $editors-concept
					
let $lemma-template := parse-xml(unparsed-text($ontology-github-url || "/templates/lemma.xml"))
(: process the controlled vocabulary for languages :)
let $languages :=
	serialize(
		<select>
			{
				for $concept in $languages-concepts
				return <option xmlns="http://www.w3.org/1999/xhtml" label="{$concept/skos:prefLabel}" value="{$concept/skos:notation}" />		
			}
		</select>
		,
		<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
			<output:method value="xml" />
			<output:omit-xml-declaration value="yes" />
			<output:indent value="yes" />
		</output:serialization-parameters>
	)
	
(: process the controlled vocabulary for usages :)
let $usages-types :=
	serialize(
		<select>
			{
				for $concept in $usages-types-concepts
				return <option xmlns="http://www.w3.org/1999/xhtml" label="{$concept/skos:prefLabel}" value="{$concept/skos:hiddenLabel}" />			
			}
		</select>
		,
		<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
			<output:method value="xml" />
			<output:omit-xml-declaration value="yes" />
			<output:indent value="yes" />
		</output:serialization-parameters>
	)	

(: process the controlled vocabulary for special characters :)
let $special-characters :=
	(
		<properties xmlns="">
			{
				for $concept in parse-xml(unparsed-text($ontology-github-url || "/special-characters.rdf"))//skos:Concept
				return <entry key="{$concept/skos:hiddenLabel}">{$concept/skos:prefLabel/text()}</entry>		
			}		
		</properties>
	)


return (
	local:generate-datalist("headword-etymology-types", "", $headword-etymology-types-concepts/skos:hiddenLabel/text(), true())
	,
	local:generate-datalist("sense-etymology-types", "", $sense-etymology-types-concepts/skos:hiddenLabel/text(), true())
	,
	local:generate-datalist("variant-etymology-types", "", $variant-etymology-types-concepts/skos:hiddenLabel/text(), true())
	,
	local:generate-datalist("etymological-note-types", $etymological-note-types-concepts/skos:prefLabel/text(), $etymological-note-types-concepts/skos:notation/text(), true())
	,
	local:generate-datalist("languages", $languages-concepts/skos:altLabel/text(), $languages-concepts/skos:notation/text(), true())
	,
	local:generate-datalist("usages-types", $usages-types-concepts/skos:prefLabel/text(), $usages-types-concepts/skos:hiddenLabel/text(), true())
	,
	local:generate-datalist("semantic-units", $semantic-units-concepts/skos:prefLabel/text(), $semantic-units-concepts/skos:hiddenLabel/text(), false())
	,
	local:generate-datalist("redactors", for $redactor-concept in $redactors-concepts return $redactor-concept/foaf:Person/foaf:name/text(), for $redactor-concept in $redactors-concepts return $redactor-concept/skos:notation/text(), true())
	,
	local:generate-datalist("editors", for $editor-concept in $editors-concepts return $editor-concept/foaf:Person/foaf:name/text(), for $editor-concept in $editors-concepts return $editor-concept/skos:notation/text(), true())
	,
	file:write-text($frameworkResourcesDirPath || "/ontology/languages.html", $languages)
	,
	file:write-text($frameworkResourcesDirPath || "/ontology/usages-types.html", $usages-types)
	,	
	file:write($frameworkDirPath || "/templates/lemma.xml", $lemma-template)	
    ,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/ontology/languages.html",
			bin:encode-string($languages)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/ontology/usages-types.html",
			bin:encode-string($usages-types)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"templates/lemma.xml",
			bin:encode-string(
				serialize(
					$lemma-template,
					<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
					  <output:indent value="yes" />
					</output:serialization-parameters>
				)
			)			
		)
	)
	,
	file:write-binary(
		$frameworkJarPath,	
		arch:update(
			file:read-binary($frameworkJarPath),
			"special-characters.xml",
			bin:encode-string(
				serialize(
					$special-characters,
					<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
					  <output:indent value="yes" />
					  <output:doctype-system value="http://java.sun.com/dtd/properties.dtd" />
					</output:serialization-parameters>
				)
			)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"java/framework.jar",
			file:read-binary($frameworkJarPath)
		)
	)
)
