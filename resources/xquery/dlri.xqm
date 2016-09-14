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
