xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "../resources/xquery/dlr.xqm";

declare namespace uuid = "java:java.util.UUID";

let $processed-template :=
	copy $template := $dlr:sense-template
	modify replace value of node $template/@xml:id with concat('uuid-', uuid:randomUUID())
	return $template
	
return insert node $processed-template as first into .
