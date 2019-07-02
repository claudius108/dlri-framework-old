xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(parent::*/(tei:stress | tei:oVar)) > 0)
then insert node $dlr:bibl-template after parent::*/(tei:stress | tei:dictScrap[@rend =  'usg'] | tei:oVar)[last()]
else insert node $dlr:bibl-template after .
