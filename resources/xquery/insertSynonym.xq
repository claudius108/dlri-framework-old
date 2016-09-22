xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template :=
	copy $template := doc('../../content-models/ptr.xml')
	modify replace value of node $template//@type with 'syn'
	return $template

return insert node $processed-template after .
