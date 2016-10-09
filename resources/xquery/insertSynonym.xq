xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

let $processed-template :=
	copy $template := $dlri:ptr-template
	modify replace value of node $template//@type with 'syn'
	return $template

return insert node $processed-template after .
