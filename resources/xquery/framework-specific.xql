xquery version "3.0";

declare namespace file = "http://expath.org/ns/file";
declare namespace skos = "http://www.w3.org/2004/02/skos/core#"; 

declare variable $pluginInstallDirPath external;
declare variable $frameworkDirPath external;

declare variable $ontology-github-url := "https://raw.githubusercontent.com/lingv-ro/controlled-vocabularies/master";
declare variable $charset := "@charset &quot;utf-8&quot;; ";

(: download the controlled vocabulary with etymology types :)
let $etymology-types :=
	for $concept in doc($ontology-github-url || "/etymology-types.rdf")//skos:Concept
	return $concept/skos:prefLabel/text()
let $processed-etymology-types :=
	string-join(
		(
			$charset,
			"&#10;",
			"@etymology-types: ",
			"&quot;",
			",",
			normalize-space(string-join($etymology-types, ",")),
			"&quot;",
			";"
		),
		""
	)

(: download the controlled vocabulary with languages :)
let $languages :=
	<select>
		{
			for $concept in doc($ontology-github-url || "/languages.rdf")//skos:Concept
			return <option label="{$concept/skos:prefLabel}" value="{$concept/skos:notation}" />		
		}
	</select>		


return (
	file:write-text(file:path-to-native($frameworkDirPath || "/resources/css/datalists/etymology-types.less"), $processed-etymology-types)
	,
	file:write(
		file:path-to-native($frameworkDirPath || "/resources/ontology/languages.html"),
		$languages,
		<output:serialization-parameters xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization">
		  <output:omit-xml-declaration value="yes" />
		  <output:indent value="yes" />
		</output:serialization-parameters>		
	)
)
