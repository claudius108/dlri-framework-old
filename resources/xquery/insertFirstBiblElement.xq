xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(| tei:pron | tei:pRef | tei:usg | tei:gen | tei:case | tei:ptr | tei:mood | tei:tns
	| tei:per | tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:stress | tei:oVar
	| tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation']
	| tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'] | tei:form[@type = 'grammatical-information'] | tei:mentioned) = 0)
then insert node $dlri:bibl-template as first into .
else insert node $dlri:bibl-template after (| tei:pron | tei:pRef | tei:usg | tei:gen | tei:case | tei:ptr | tei:mood
	| tei:tns | tei:per | tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:stress | tei:oVar
	| tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation']
	| tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'] | tei:form[@type = 'grammatical-information'] | tei:mentioned)[last()]
