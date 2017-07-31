xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name() = 'TEI')
then insert node doc('../../content-models/abbreviation.xml') after //tei:entry/(tei:dictScrap[@xml:id = 'dex-senses'] | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation'] | tei:form[@type = 'writing'])[last()]
else insert node doc('../../content-models/abbreviation.xml') after (tei:def | tei:gramGrp | tei:usg | tei:ptr | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation'] | tei:form[@type = 'writing'])[last()]
