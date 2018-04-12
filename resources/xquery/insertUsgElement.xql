xquery version "3.0";

let $context-node := .
let $context-node-local-name := local-name($context-node) 
let $corresp-value :=
	switch ($context-node-local-name) 
	   case "def" return concat('#', $context-node/@xml:id)
	   case "usg" return $context-node/@corresp
	   default return ""
let $template-content := doc('../../content-models/usg.xml')

let $processed-template :=
	if ($corresp-value != '')
	then
		copy $template := $template-content
		modify insert node attribute {'corresp'} {$corresp-value} into $template/*
		return $template
	else $template-content

return insert node $processed-template after $context-node
