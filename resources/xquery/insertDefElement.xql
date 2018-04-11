xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace uuid = "java:java.util.UUID";

let $processed-template :=
	copy $template := $dlri:def-template
	modify replace value of node $template/@xml:id with concat('uuid-', uuid:randomUUID())
	return $template
	
return insert node $processed-template after (. | following-sibling::tei:usg | following-sibling::tei:ptr)[last()]
