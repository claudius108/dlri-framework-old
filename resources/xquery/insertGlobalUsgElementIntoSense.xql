xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $corresp-value := concat('#', $context-node/@xml:id)
let $processed-template :=
	copy $template := $dlr:usg-container-template
	modify insert node attribute {'corresp'} {$corresp-value} into $template
	
	return $template


return
	if (element()[1]/local-name() = 'gramGrp')
	then insert node $processed-template after element()[1]
	else insert node $processed-template as first into .
