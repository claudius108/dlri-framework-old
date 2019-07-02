xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace uuid = "java:java.util.UUID";

let $context-node := .
let $corresp-value := concat('#', $context-node/@xml:id)

let $processed-template :=
	copy $template := $dlr:def-template
	modify replace value of node $template/@xml:id with concat('uuid-', uuid:randomUUID())
	return $template
	
return insert node $processed-template after ($context-node | $context-node/(following-sibling::tei:dictScrap, following-sibling::tei:term)[@corresp = $corresp-value] | $context-node/following-sibling::tei:ptr[@type = ('syn', 'analog', 'asoc', 'antonim') and @corresp = $corresp-value])[last()]
