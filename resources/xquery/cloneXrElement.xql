xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $context-node-type := $context-node/@type
let $context-node-corresp := $context-node/@corresp
 
let $processed-template :=
	copy $template := $dlr:xr-template
	modify (
		replace value of node $template/@type with $context-node-type
		,
		insert node $context-node-corresp into $template	
	)

	return $template

return insert node $processed-template after $context-node
