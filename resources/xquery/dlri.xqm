xquery version "3.0";

module namespace dlri = "http://dlri.ro/ns/dlri/";

declare variable $dlri:gramGrp-template as element() :=
   <gramGrp xmlns="http://www.tei-c.org/ns/1.0">
       <pos value="" />
   </gramGrp>
;

declare variable $dlri:lexical-variant-section-template as element() :=
	<form xmlns="http://www.tei-c.org/ns/1.0" type="lexical-variant-section">
        <form type="lexical-variant" />
        {$dlri:gramGrp-template}
    </form>
;

declare variable $dlri:analogy-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" type="analog" target="unknown" />
;

declare variable $dlri:association-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" type="asoc" target="unknown" />
;

declare variable $dlri:antonym-template as element() :=
    <ptr xmlns="http://www.tei-c.org/ns/1.0" type="antonim" target="unknown" />
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
