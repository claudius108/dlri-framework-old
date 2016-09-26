xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "../resources/xquery/dlri.xqm";

declare namespace uuid = "java:java.util.UUID";

let $processed-template :=
	copy $template := $dlri:sense-template
	modify replace value of node $template/@xml:id with concat('uuid-', uuid:randomUUID())
	return $template
	
return insert node $processed-template as first into .
