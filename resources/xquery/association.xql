xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $last-def-element := dlr:get-last-def-component($context-node)

let $processed-template :=
	copy $template := $dlr:xr-template
	modify replace value of node $template/@type with 'asoc'
	
	return $template


return insert node $processed-template after ($last-def-element | $context-node/tei:term[@xml:lang = 'la'] | $context-node/following-sibling::tei:xr[@type = 'analog'])[last()]
