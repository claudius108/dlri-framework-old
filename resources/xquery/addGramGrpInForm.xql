xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node $dlri:gramGrp-template after (tei:number | tei:usg | tei:gramGrp | tei:ptr)[last()]
