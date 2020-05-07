xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $corresp-value := concat('#', $context-node/@xml:id)
	   
let $processed-template :=
	copy $template := $dlr:xr-template
	modify replace value of node $template/@type with 'syn'
	
	return $template


return insert node $processed-template as first into $context-node
