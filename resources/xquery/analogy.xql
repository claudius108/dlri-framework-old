xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .

let $processed-template :=
	copy $template := $dlr:xr-template
	modify replace value of node $template/@type with 'analog'
		
	return $template
let $delimiter := (dlr:get-last-def-component($context-node) | $context-node/tei:xr[@type = 'syn' and not(@corresp)] | $context-node/tei:term[@xml:lang = 'la'])[last()]

return insert node $processed-template after $delimiter
