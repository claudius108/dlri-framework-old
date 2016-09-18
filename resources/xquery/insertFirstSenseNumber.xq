xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(tei:usg | tei:gen | tei:case | tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:gramGrp | tei:form[@type = 'lexical-variant']) = 0)
then insert node doc('../../content-models/sense-number-pointer.xml') as first into .
else insert node doc('../../content-models/sense-number-pointer.xml') after (tei:usg | tei:gen | tei:case | tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:gramGrp | tei:form[@type = 'lexical-variant'])[last()]
