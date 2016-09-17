xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name() = 'sense')
then insert node $dlri:gramGrp-template as first into .
else insert node $dlri:gramGrp-template after .
