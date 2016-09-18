xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (count(parent::*/(tei:stress | tei:oVar)) > 0)
then insert node $dlri:bibl-template after parent::*/(tei:stress | tei:usg | tei:oVar)[last()]
else insert node $dlri:bibl-template after .
