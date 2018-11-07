<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
	<ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#" />
	<ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#" />
	<pattern>
		<title>Non-empty text inputs</title>
		<rule
			context="skos:prefLabel | skos:altLabel | skos:Concept[starts-with(@rdf:about, 'http://lingv.ro/ontology/languages')]/skos:notation | skos:definition | skos:Concept[starts-with(@rdf:about, 'http://lingv.ro/ontology/special-characters')]/skos:notation">
			<assert test="string-length(.) != 0">Completați această căsuță text!</assert>
		</rule>
	</pattern>
	<pattern>
		<title>Duplicated concepts</title>
		<rule context="skos:Concept">
			<report
				test="count(index-of(current()/parent::*/skos:Concept/string() ! normalize-space(.), normalize-space(current()/string()))) > 1">Concept dublat!</report>
		</rule>
	</pattern>

	<pattern>
		<title>Language datatype</title>
		<rule context="skos:OrderedCollection[@rdf:about = 'http://lingv.ro/ontology/languages']//skos:notation">
			<assert test=". castable as xs:language">
				Codul de limbă ales nu este corect! Vedeți https://www.w3.org/International/articles/language-tags/. 
			</assert>
		</rule>
	</pattern>
</schema>
