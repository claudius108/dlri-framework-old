xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node doc('../../content-models/reference.xml') after (tei:usg | tei:ptr[@type = 'trimitere'] | tei:def)[last()]
