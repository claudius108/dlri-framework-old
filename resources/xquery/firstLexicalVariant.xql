xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $last-def-element := dlr:get-last-def-component($context-node)

let $headword-delimiter := //tei:entry/(tei:dictScrap[@xml:id = 'dex-senses'] | tei:form[contains(' unknown-accentuation accentuation-variant ', @type)] | tei:form[@type = 'pronunciation'] | tei:form[@type = 'writing'] | tei:form[@type = 'abbreviation'] | tei:form[@type = 'grammatical-information'])[last()]
let $sense-delimiter := (dlr:get-last-def-component($context-node) | $context-node/tei:xr[@type = 'syn' and not(@corresp)] | $context-node/tei:term[@xml:lang = 'la'] | $context-node/tei:xr[@type = ('asoc', 'analog')] | $context-node/tei:ptr[@type = 'trimitere'] | tei:cit)[last()]

return insert node $dlr:lexical-variant-section-template after ($headword-delimiter, $sense-delimiter)[last()]
