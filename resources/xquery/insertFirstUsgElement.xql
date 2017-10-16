xquery version "3.0";

declare default element namespace "http://www.tei-c.org/ns/1.0";

(
	if (count(orth | ref | syll | pron | pRef | number | case | mood | tns | per | form[@type = 'details-for-grammatical-information-for-verb'] | stress | gramGrp | oVar) = 0 and @type != 'unitate-semantică-subsumată')
	then insert node doc('../../content-models/usg.xml') as first into .
	else ()
	,
	if (@type = 'unitate-semantică-subsumată')
	then insert node doc('../../content-models/usg.xml') after term[1]
	else ()
	,
	if (count(orth | ref | syll | pron | pRef | number | case | mood | tns | per | form[@type = 'details-for-grammatical-information-for-verb'] | stress | gramGrp | oVar) > 0) 
	then insert node doc('../../content-models/usg.xml') after (orth | ref | syll | pron | pRef | number | case | mood | tns | per | form[@type = 'details-for-grammatical-information-for-verb'] | stress | gramGrp | oVar)[last()]
	else ()
)
