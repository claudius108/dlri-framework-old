xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $corresp-value := concat('#', $context-node/@xml:id)
	   
let $processed-template :=
	copy $template := $dlr:term-la-template
	modify insert node attribute {'corresp'} {$corresp-value} into $template
	return $template


return insert node $processed-template after ($context-node | $context-node/following-sibling::tei:usg[@corresp = $corresp-value] | $context-node/following-sibling::tei:xr[@type = ('syn', 'remote-syn', 'analog', 'asoc', 'antonim') and @corresp = $corresp-value])[last()]	
