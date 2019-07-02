xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name(.) = 'TEI') then (insert node doc('../../content-models/accentuation.xml') after //tei:entry/tei:dictScrap[@xml:id = 'dex-senses']) else (insert node doc('../../content-models/accentuation.xml') after (tei:def | tei:gramGrp | tei:dictScrap[@rend =  'usg'] | tei:ptr)[last()])
