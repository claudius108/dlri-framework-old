xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-term-template :=
	copy $template := $dlr:term-template
	modify replace value of node $template/@type with 'translation'
	return $template

return
	if (tei:note)
	then insert node $processed-term-template before tei:note[1]
	else insert node $processed-term-template as last into .
