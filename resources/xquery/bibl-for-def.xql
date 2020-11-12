xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

let $context-node := .
let $context-node-local-name := local-name($context-node)
 
let $corresp-value :=
	switch ($context-node-local-name) 
	   case "def" return concat('#', $context-node/@xml:id)
	   default return ""
let $template-content := $dlr:bibl-template
let $processed-template :=
	if ($corresp-value != '')
	then
		copy $template := $template-content
		modify (
            insert node attribute {'corresp'} {$corresp-value} into $template
            ,
            insert node attribute {'subtype'} {'bibl-for-def'} into $template
        )
		
		return $template
	else $template-content

return insert node $processed-template after $context-node
