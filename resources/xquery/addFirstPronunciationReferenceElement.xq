xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(tei:syll | tei:pron) = 0)
then insert node doc('../../content-models/pRef.xml') as first into .
else insert node doc('../../content-models/pRef.xml') after (tei:syll | tei:pron)[last()]
