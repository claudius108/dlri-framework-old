xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $context-node-local-name := local-name($context-node) 
let $corresp-value :=
	switch ($context-node-local-name) 
	   case "def" return concat('#', $context-node/@xml:id)
	   case "ptr" return $context-node/@corresp
	   default return ""
	   
let $processed-template :=
	if ($corresp-value != '')
	then
		copy $template := $dlr:ptr-template
		modify (
			replace value of node $template//@type with 'asoc'
			,
			insert node attribute {'corresp'} {$corresp-value} into $template
		)
		return $template
	else $dlr:ptr-template	


return
	if (local-name() = 'ptr')
	then insert node $processed-template after $context-node
	else insert node $processed-template after ($context-node | following-sibling::tei:usg[@corresp = $corresp-value] | $context-node/following-sibling::tei:ptr[@type = ('syn', 'analog') and @corresp = $corresp-value])[last()]	
