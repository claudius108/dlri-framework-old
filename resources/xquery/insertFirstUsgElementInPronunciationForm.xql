xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

if (element())
then insert node $dlr:usg-container-template after (pron | pRef)[last()]
else insert node $dlr:usg-container-template as first into .
