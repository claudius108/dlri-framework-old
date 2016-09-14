xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name() = 'TEI')
then insert node doc('../../content-models/grammatical-information.xml') after //tei:entry/(tei:sense | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation'] | tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'])[last()]
else insert node doc('../../content-models/grammatical-information.xml') after (tei:form[type = 'lexical-variant'] | tei:gramGrp | tei:usg | tei:ptr | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation'] | tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'])[last()]
