xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name() = 'TEI')
then (insert node doc('../../content-models/pronunciation-form.xml') after //tei:entry/(tei:dictScrap[@xml:id = 'dex-senses'] | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'articulation'])[last()])
else insert node doc('../../content-models/pronunciation-form.xml') after (tei:def | tei:gramGrp | tei:dictScrap[@rend =  'usg'] | tei:ptr | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)])[last()]
