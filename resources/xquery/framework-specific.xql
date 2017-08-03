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
let $processed-headword-etymology-types := string-join(
	(
		$charset,
		"&#10;",
		"@headword-etymology-types: ",
		"&quot;",
		",",
		normalize-space(string-join($headword-etymology-types, ",")),
		"&quot;",
		";"
	),
	""
)
let $processed-sense-etymology-types := string-join(
	(
		$charset,
		"&#10;",
		"@sense-etymology-types: ",
		"&quot;",
		",",
		normalize-space(string-join($sense-etymology-types, ",")),
		"&quot;",
		";"
	),
	""
)
let $processed-variant-etymology-types := string-join(
	(
		$charset,
		"&#10;",
		"@variant-etymology-types: ",
		"&quot;",
		",",
		normalize-space(string-join($variant-etymology-types, ",")),
		"&quot;",
		";"
	),
	""
)

(: process the controlled vocabulary for languages :)
let $languages :=
	<select>
		{
			for $concept in parse-xml(unparsed-text($ontology-github-url || "/languages.rdf"))//skos:Concept
			return <option xmlns="http://www.w3.org/1999/xhtml" label="{$concept/skos:prefLabel}" value="{$concept/skos:notation}" />		
		}
	</select>	
let $serialized-languages :=
	serialize(
		$languages,
		<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
			<output:method value="xml" />
			<output:omit-xml-declaration value="yes" />
			<output:indent value="yes" />
		</output:serialization-parameters>
	)	

(: process the controlled vocabulary for special characters :)
let $special-characters :=
	(
		<properties>
			{
				for $concept in parse-xml(unparsed-text($ontology-github-url || "/special-characters.rdf"))//skos:Concept
				return <entry key="{$concept/skos:notation}">{$concept/skos:definition/text()}</entry>		
			}		
		</properties>
	)


return (
	file:write-text($frameworkResourcesDirPath || "/css/datalists/headword-etymology-types.less", $processed-headword-etymology-types)
    ,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/sense-etymology-types.less", $processed-sense-etymology-types)
    ,
	file:write-text($frameworkResourcesDirPath || "/css/datalists/variant-etymology-types.less", $processed-variant-etymology-types)
    ,
	file:write-text($frameworkResourcesDirPath || "/ontology/languages.html", $serialized-languages)
    ,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/headword-etymology-types.less",
			bin:encode-string($processed-headword-etymology-types)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/sense-etymology-types.less",
			bin:encode-string($processed-sense-etymology-types)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/css/datalists/variant-etymology-types.less",
			bin:encode-string($processed-variant-etymology-types)
		)
	)
	,
	file:write-binary(
		$frameworkUberJarPath,	
		arch:update(
			file:read-binary($frameworkUberJarPath),
			"resources/ontology/languages.html",
			bin:encode-string($serialized-languages)
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
)
