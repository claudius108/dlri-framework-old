xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $context-node-name := $context-node/local-name()


return
	if ($context-node-name = 'TEI')
	then insert node <note xmlns="http://www.tei-c.org/ns/1.0" type="bibliographic-references">{$dlr:bibl-template}</note> as last into $context-node/tei:text/tei:body/tei:entry
	else
		if (count(tei:pron | tei:pRef | tei:usg | tei:gen | tei:case | tei:ptr | tei:mood | tei:tns
			| tei:per | tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:stress | tei:oVar
			| tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation']
			| tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'] | tei:form[@type = 'grammatical-information'] | tei:mentioned | tei:def) = 0)
		then insert node $dlr:bibl-template as first into .
		else insert node $dlr:bibl-template after (tei:pron | tei:pRef | tei:usg | tei:gen | tei:case | tei:ptr | tei:mood
			| tei:tns | tei:per | tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:stress | tei:oVar
			| tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation']
			| tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'] | tei:form[@type = 'grammatical-information'] | tei:mentioned | tei:def)[last()]
