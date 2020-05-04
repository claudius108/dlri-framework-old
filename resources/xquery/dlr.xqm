xquery version "3.0";

module namespace dlr = "http://lingv.ro/ns/dlr/";

declare variable $dlr:gramGrp-template as element() :=
   <gramGrp xmlns="http://www.tei-c.org/ns/1.0">
       <pos value="" />
   </gramGrp>
;

declare variable $dlr:lexical-variant-section-template as element() :=
	<re xmlns="http://www.tei-c.org/ns/1.0" type="lexical-variant-section">
        <def />
        {$dlr:gramGrp-template}
    </re>
;

declare variable $dlr:def-template as element() :=
    <def xmlns="http://www.tei-c.org/ns/1.0" xml:id="id" />
;

declare variable $dlr:bibl-template as element() :=
    <bibl xmlns="http://www.tei-c.org/ns/1.0" type="unknown">
        <ptr target="unknown" />
        <date />
        <citedRange />
    </bibl>
;

declare variable $dlr:cit-template as element() :=
    <cit xmlns="http://www.tei-c.org/ns/1.0" type="unknown">
        <quote />
        {$dlr:bibl-template}
    </cit>
;

declare variable $dlr:term-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="unknown" subtype="unknown" />
;

declare variable $dlr:term-prefix-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="prefix" subtype="unknown" />
;

declare variable $dlr:term-sufix-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="sufix" subtype="unknown" />
;

declare variable $dlr:term-la-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="la" type="unknown" subtype="unknown" />
;

declare variable $dlr:term-una.sau.mai.multe.variante.lexicale-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="una.sau.mai.multe.variante.lexicale" />
;

declare variable $dlr:term-una.sau.mai.multe.variante.lexicale-cf.-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="una.sau.mai.multe.variante.lexicale-cf." />
;

declare variable $dlr:term-unul.sau.mai.multe.sensuri-sensul-cf.-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="unul.sau.mai.multe.sensuri-sensul-cf." />
;

declare variable $dlr:term-formație.internă-compus-format.din-bază-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="formație.internă-compus-format.din-bază" />
;

declare variable $dlr:term-formație.internă-compus-format.din-element.adăugat-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="formație.internă-compus-format.din-element.adăugat" />
;

declare variable $dlr:term-formație.internă-trimitere-Cf.-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="formație.internă-trimitere-Cf." />
;

declare variable $dlr:xr-template as element() :=
	<xr xmlns="http://www.tei-c.org/ns/1.0" type="unknown">
    	<ptr target="unknown" />
    </xr>
;

declare variable $dlr:ptr-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="unknown" subtype="unknown" target="unknown" />
;

declare variable $dlr:ptr-una.sau.mai.multe.variante.lexicale-cf.-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="una.sau.mai.multe.variante.lexicale-cf." target="unknown" />
;

declare variable $dlr:ptr-unul.sau.mai.multe.sensuri-sensul-cf.-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="unul.sau.mai.multe.sensuri-sensul-cf." target="unknown" />
;

declare variable $dlr:ptr-base-word-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="base-word" subtype="unknown" target="unknown" />
;

declare variable $dlr:ptr-component-element-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="" type="component-element" subtype="unknown" target="unknown" />
;

declare variable $dlr:ptr-formație.internă-compus-format.din-bază-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="formație.internă-compus-format.din-bază" target="unknown" />
;

declare variable $dlr:ptr-formație.internă-compus-format.din-element.adăugat-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="formație.internă-compus-format.din-element.adăugat" target="unknown" />
;

declare variable $dlr:ptr-formație.internă-trimitere-Cf.-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" targetLang="ro" type="formație.internă-trimitere-Cf." />
;

declare variable $dlr:sense-template as element() :=
    <sense xmlns="http://www.tei-c.org/ns/1.0" xml:id="id" n="">
        {$dlr:cit-template}
    </sense>
;

declare variable $dlr:semantic-unit-template as element() :=
	<form xmlns="http://www.tei-c.org/ns/1.0" type="unitate-semantică-subsumată">
		<idno n="tip-unitate-semantică-subsumată" type="unknown" />
		<term />
	</form>
;

declare variable $dlr:usg-container-template as element() :=
	<usg xmlns="http://www.tei-c.org/ns/1.0" />
;
