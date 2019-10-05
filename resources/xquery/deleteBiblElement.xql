xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $parent-node := $context-node/parent::*
let $parent-node-local-name := $parent-node/local-name()
 
return
	if ($parent-node-local-name = 'note')
	then
		let $bibl-elements := count($parent-node/tei:bibl)
		
		return
			if ($bibl-elements > 1)
			then delete node $context-node
			else delete node $parent-node
	else delete node $context-node
