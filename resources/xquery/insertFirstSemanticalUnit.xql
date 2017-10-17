xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

insert node $dlri:semantical-unit-template before def[1]
