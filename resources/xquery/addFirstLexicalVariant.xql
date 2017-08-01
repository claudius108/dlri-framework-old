xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node $dlri:lexical-variant-section-template after (//tei:entry/(tei:dictScrap[@xml:id = 'dex-senses'] | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation'] | tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'] | tei:form[@type = 'grammatical-information']) | tei:cit)[last()]
