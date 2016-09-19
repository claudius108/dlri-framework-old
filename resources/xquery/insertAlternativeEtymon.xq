xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template-1 :=
	copy $template := $dlri:term-template 
	modify replace value of node $template/@type with 'contamination-element'
	return $template
let $processed-template-2 :=
	copy $template := $dlri:term-template 
	modify replace value of node $template/@type with 'alternative-contamination-element'
	return $template	

return insert nodes ($processed-template-1, $processed-template-2) after .
