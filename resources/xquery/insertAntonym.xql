xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

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
		copy $template := $dlri:ptr-template
		modify (
			replace value of node $template//@type with 'antonim'
			,
			insert node attribute {'corresp'} {$corresp-value} into $template
		)
		return $template
	else $dlri:ptr-template	

return
	if (local-name() = 'ptr')
	then insert node $processed-template after .
	else insert node $processed-template after (following-sibling::tei:ptr[@type = ('analog', 'syn', 'asoc', 'antonim')] | .)[last()]
