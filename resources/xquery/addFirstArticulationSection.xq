xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node doc('../../content-models/articulation.xml') after //tei:entry/(tei:dictScrap[@xml:id = 'dex-senses'] | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)])[last()]
