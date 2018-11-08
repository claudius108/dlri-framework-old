<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
	<ns prefix="tei" uri="http://www.tei-c.org/ns/1.0" />
	<pattern>
		<title>Text between elements</title>
		<rule context="element()[element() and normalize-space(string-join(text(), '')) != '']">
			<report test="local-name() != 'usg'">Nu trebuie să existe text în afara căsuțelor pentru text!</report>
		</rule>
	</pattern>

	<pattern>
		<title>Duplicated quotes</title>
		<rule context="tei:cit">
			<report
				test="count(index-of(current()/parent::*/tei:cit/string() ! normalize-space(.), normalize-space(current()/string()))) > 1">Citat dublat!</report>
		</rule>
	</pattern>
</schema>
