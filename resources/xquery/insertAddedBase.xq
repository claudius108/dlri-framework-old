xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template :=
	copy $template := $dlr:term-template
	modify replace value of node $template/@type with 'added-base'
	return $template

return insert node $processed-template after .
