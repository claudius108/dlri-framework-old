xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(tei:def | tei:orth | tei:ref | tei:syll | tei:pron | tei:pRef | tei:number | tei:case | tei:mood | tei:tns | tei:per
| tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:stress | tei:gramGrp | tei:oVar | tei:form[@type = 'lexical-variant']) = 0)
then insert node doc('../../content-models/usg.xml') as first into .
else insert node doc('../../content-models/usg.xml') after (tei:def | tei:orth | tei:ref | tei:syll | tei:pron | tei:pRef | tei:number | tei:case | tei:mood | tei:tns | tei:per
| tei:form[@type = 'details-for-grammatical-information-for-verb'] | tei:stress | tei:gramGrp | tei:oVar | tei:form[@type = 'lexical-variant'])[last()]
