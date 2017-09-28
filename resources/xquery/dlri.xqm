xquery version "3.0";

module namespace dlri = "http://dlri.ro/ns/dlri/";

declare variable $dlri:gramGrp-template as element() :=
   <gramGrp xmlns="http://www.tei-c.org/ns/1.0">
       <pos value="" />
   </gramGrp>
;

declare variable $dlri:lexical-variant-section-template as element() :=
	<re xmlns="http://www.tei-c.org/ns/1.0" type="lexical-variant-section">
        <def />
        {$dlri:gramGrp-template}
    </re>
;

declare variable $dlri:def-template as element() :=
    <def xmlns="http://www.tei-c.org/ns/1.0" n="" />
;

declare variable $dlri:bibl-template as element() :=
    <bibl xmlns="http://www.tei-c.org/ns/1.0" type="unknown">
        <ptr target="unknown" />
        <date />
        <citedRange />
    </bibl>
;

declare variable $dlri:cit-template as element() :=
    <cit xmlns="http://www.tei-c.org/ns/1.0">
        <quote />
        {$dlri:bibl-template}
    </cit>
;

declare variable $dlri:term-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="unknown" subtype="unknown" />
;

declare variable $dlri:term-prefix-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="prefix" subtype="unknown" />
;

declare variable $dlri:term-sufix-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="sufix" subtype="unknown" />
;

declare variable $dlri:term-la-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="la" type="unknown" subtype="unknown" />
;

declare variable $dlri:term-una.sau.mai.multe.variante.lexicale-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="una.sau.mai.multe.variante.lexicale" />
;

declare variable $dlri:term-una.sau.mai.multe.variante.lexicale-cf.-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="una.sau.mai.multe.variante.lexicale-cf." />
;

declare variable $dlri:term-unul.sau.mai.multe.sensuri-sensul-cf.-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="unul.sau.mai.multe.sensuri-sensul-cf." />
;

declare variable $dlri:term-cuvântul.titlu-formație.internă-compus-format.din-bază-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="cuvântul.titlu-formație.internă-compus-format.din-bază" />
;

declare variable $dlri:term-cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="cuvântul.titlu-formație.internă-compus-format.din-element.adăugat" />
;

declare variable $dlri:term-cuvântul.titlu-formație.internă-trimitere-Cf.-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="cuvântul.titlu-formație.internă-trimitere-Cf." />
;

declare variable $dlri:ptr-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="unknown" subtype="unknown" target="unknown" />
;

declare variable $dlri:ptr-una.sau.mai.multe.variante.lexicale-cf.-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="una.sau.mai.multe.variante.lexicale-cf." target="unknown" />
;

declare variable $dlri:ptr-unul.sau.mai.multe.sensuri-sensul-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="unul.sau.mai.multe.sensuri-sensul" target="unknown" />
;

declare variable $dlri:ptr-unul.sau.mai.multe.sensuri-sensul-cf.-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="unul.sau.mai.multe.sensuri-sensul-cf." target="unknown" />
;

declare variable $dlri:ptr-base-word-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="base-word" subtype="unknown" target="unknown" />
;

declare variable $dlri:ptr-component-element-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="component-element" subtype="unknown" target="unknown" />
;

declare variable $dlri:ptr-cuvântul.titlu-formație.internă-compus-format.din-bază-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="cuvântul.titlu-formație.internă-compus-format.din-bază" target="unknown" />
;

declare variable $dlri:ptr-cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="cuvântul.titlu-formație.internă-compus-format.din-element.adăugat" target="unknown" />
;

declare variable $dlri:ptr-cuvântul.titlu-formație.internă-trimitere-Cf.-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="cuvântul.titlu-formație.internă-trimitere-Cf." />
;

declare variable $dlri:sense-template as element() :=
    <sense xmlns="http://www.tei-c.org/ns/1.0" xml:id="id">
        <idno n="" type="level-label" />
        {$dlri:def-template}
        {$dlri:cit-template}
    </sense>
;

declare variable $dlri:semantical-unit-template as element() :=
	<form xmlns="http://www.tei-c.org/ns/1.0" type="unitate-semantică-subsumată">
		<idno n="tip-unitate-semantică-subsumată" type="unknown" />
		<term />
	</form>
;

