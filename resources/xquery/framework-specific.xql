xquery version "3.0";

declare namespace file = "http://expath.org/ns/file";
declare namespace arch = "http://expath.org/ns/archive";
declare namespace bin = "http://expath.org/ns/binary";

declare namespace skos = "http://www.w3.org/2004/02/skos/core#";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";

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

declare function local:generate-datalist($datalist-name, $datalist-labels, $datalist-values) {
	string-join(
		(
			$charset,
			"&#10;",
			"@" || $datalist-name || "-labels: ",
			"&quot;" || $datalist-labels || "&quot;",
			";",
			"&#10;",
			"@" || normalize-space($datalist-name) || "-values: ",
			"&quot;" || normalize-space($datalist-values) || "&quot;",
			";"			
		),
		""
	)
};

(: process the controlled vocabulary for etymology types :)
let $etymology-types := parse-xml(unparsed-text($ontology-github-url || "/etymology-types.rdf"))
let $headword-etymology-types :=
	for $concept in $etymology-types//skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/etymology-types/headword']//skos:Concept
	return $concept/skos:prefLabel/text()
let $sense-etymology-types :=
	for $concept in $etymology-types//skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/etymology-types/sense']//skos:Concept
	return $concept/skos:prefLabel/text()
let $variant-etymology-types :=
	for $concept in $etymology-types//skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/etymology-types/variant']//skos:Concept
	return $concept/skos:prefLabel/text()
let $languages-concepts := parse-xml(unparsed-text($ontology-github-url || "/languages.rdf"))//skos:Concept
let $usage-options-concepts := parse-xml(unparsed-text($ontology-github-url || "/usages.rdf"))//skos:OrderedCollection[1]//skos:Concept
let $lemma-template := parse-xml(unparsed-text($ontology-github-url || "/templates/lemma.xml"))
let $semantic-units-concepts := parse-xml(unparsed-text($ontology-github-url || "/semantic-units.rdf"))//skos:OrderedCollection[1]//skos:Concept
				
let $headword-etymology-types-datalist := local:generate-datalist("headword-etymology-types", "", string-join(("", $headword-etymology-types), ","))
let $sense-etymology-types-datalist := local:generate-datalist("sense-etymology-types", "", string-join(("", $sense-etymology-types), ","))
let $variant-etymology-types-datalist := local:generate-datalist("variant-etymology-types", "", string-join(("", $variant-etymology-types), ","))
let $languages-datalist := local:generate-datalist("languages", "", string-join(("", $languages-concepts/skos:prefLabel), ","))
let $usage-options-datalist := local:generate-datalist("usage-options", "", string-join(("", $usage-options-concepts/skos:hiddenLabel), ","))
let $semantic-units-datalist := local:generate-datalist("semantic-units", string-join($semantic-units-concepts/skos:prefLabel, ","), string-join($semantic-units-concepts/skos:altLabel, ","))

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
let $usage-options :=
	serialize(
		<select>
			{
				for $concept in $usage-options-concepts
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
				return <entry key="{$concept/skos:notation}">{$concept/skos:definition/text()}</entry>		
			}		
		</properties>
	)


return (
	file:write-text($frameworkResourcesDirPath || "/css/datalists/headword-etymology-types.less", $headword-etymology-types-datalist)
    ,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/sense-etymology-types.less", $sense-etymology-types-datalist)
    ,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/variant-etymology-types.less", $variant-etymology-types-datalist)
    ,
	file:write-text($frameworkResourcesDirPath || "/ontology/languages.html", $languages)
	,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/languages.less", $languages-datalist)	
	,
	file:write-text($frameworkResourcesDirPath || "/ontology/usages.html", $usage-options)
	,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/usage-options.less", $usage-options-datalist)
	,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/semantic-units.less", $semantic-units-datalist)
	,	
	file:write($frameworkDirPath || "/templates/lemma.xml", $lemma-template)	
    ,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/headword-etymology-types.less",
			bin:encode-string($headword-etymology-types-datalist)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/sense-etymology-types.less",
			bin:encode-string($sense-etymology-types-datalist)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/variant-etymology-types.less",
			bin:encode-string($variant-etymology-types-datalist)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/languages.less",
			bin:encode-string($languages-datalist)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/usage-options.less",
			bin:encode-string($usage-options-datalist)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/semantic-units.less",
			bin:encode-string($semantic-units-datalist)
		)
	)
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
			"resources/ontology/usages.html",
			bin:encode-string($usage-options)
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
