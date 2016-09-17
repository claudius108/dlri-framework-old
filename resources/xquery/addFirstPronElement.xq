xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(tei:syll) = 0)
then insert node doc('../../content-models/pron.xml') as first into .
else insert node doc('../../content-models/pron.xml') after tei:syll[last()]
