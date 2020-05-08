xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $corresp-value := concat('#', $context-node/@xml:id)
let $processed-template :=
	copy $template := $dlr:usg-container-template
	modify insert node attribute {'corresp'} {$corresp-value} into $template
	
	return $template
let $delimiter := $context-node/tei:gramGrp[last()]

return
	if ($delimiter)
	then insert node $processed-template after $delimiter
	else insert node $processed-template as first into .
