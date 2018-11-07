<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
	<pattern>
		<title>Text between elements</title>
		<rule context="element()[element() and normalize-space(string-join(text(), '')) != '']">
			<report test="local-name() != 'usg'">Nu trebuie să existe text în afara căsuțelor pentru text!</report>
		</rule>
	</pattern>
</schema>
