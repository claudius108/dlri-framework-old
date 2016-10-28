xquery version "3.0";

declare namespace file = "http://expath.org/ns/file";
declare namespace skos = "http://www.w3.org/2004/02/skos/core#"; 

declare variable $pluginInstallDirPath external;
declare variable $frameworkDirPath external;

declare variable $ontology-github-url := "https://raw.githubusercontent.com/lingv-ro/controlled-vocabularies/master";
declare variable $charset := "@charset &quot;utf-8&quot;; ";

let $etymology-types-doc := doc($ontology-github-url || "/etymology-types.rdf")
let $etymology-types :=
	for $concept in $etymology-types-doc//skos:Concept
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

return file:write-text(file:path-to-native($frameworkDirPath || "/resources/css/datalists/etymology-types.less"), $processed-etymology-types)
