xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace uuid = "java:java.util.UUID";

let $context-node := .
	   
let $processed-template :=
	copy $template := $dlr:xr-template
	modify (
        insert node attribute xml:id {concat('uuid-', uuid:randomUUID())} into $template
        ,
        replace value of node $template/@type with 'syn'
    )
	
	return $template


return insert node $processed-template after ($context-node/tei:xr[@type = 'syn'])[last()]
