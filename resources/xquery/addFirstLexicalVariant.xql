xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

insert node $dlr:lexical-variant-section-template after (//entry/(dictScrap[@xml:id = 'dex-senses'] | form[contains(' unknown-accentuation accentuation-variant ', @type)] | form[@type = 'pronunciation'] | form[@type = 'writing'] | form[@type = 'abbreviation'] | form[@type = 'grammatical-information']) | cit)[last()]
