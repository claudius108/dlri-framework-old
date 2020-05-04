xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace uuid = "java:java.util.UUID";

let $context-node := .

let $processed-template :=
	copy $template := $dlr:def-template
	modify replace value of node $template/@xml:id with concat('uuid-', uuid:randomUUID())
	return $template
	
return insert node $processed-template as first into $context-node
