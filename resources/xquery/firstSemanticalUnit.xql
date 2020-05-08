xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $delimiter := ($context-node/tei:gramGrp | $context-node/tei:usg)[last()]

return
	if ($delimiter)
	then insert node $dlr:semantic-unit-template after $delimiter
	else insert node $dlr:semantic-unit-template as first into $context-node
