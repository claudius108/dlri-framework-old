xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name() = 'form' and @type = 'grammatical-information')
then insert node doc('../../content-models/grammatical-information.xml') after .
else insert node doc('../../content-models/grammatical-information.xml') after (tei:term | tei:ptr)[last()]
