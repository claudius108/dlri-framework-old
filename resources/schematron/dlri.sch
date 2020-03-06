<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
	<ns prefix="tei" uri="http://www.tei-c.org/ns/1.0" />
	<pattern>
		<title>Duplicated quotes</title>
		<rule context="tei:cit">
			<report
				test="count(index-of(current()/parent::*/tei:cit/string() ! normalize-space(.), normalize-space(current()/string()))) > 1">Citat dublat!</report>
		</rule>
	</pattern>
	<pattern>
		<title>Definition</title>
		<rule context="tei:def">
			<report
				test="starts-with(current(), ' ')">Definiția nu trebuie să inceapă cu spațiu!</report>
		</rule>
	</pattern>	
</schema>
