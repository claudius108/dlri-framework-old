xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (local-name() = 'ptr')
then insert node $dlri:antonym-template after .
else insert node $dlri:antonym-template after (following-sibling::tei:ptr[@type = ('analog', 'syn', 'asoc', 'antonim')] | .)[last()]
