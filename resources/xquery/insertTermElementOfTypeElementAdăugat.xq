xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template :=
	copy $template := $dlri:term-template
	modify replace value of node $template/@type with 'cuvântul.titlu-formație.internă-compus-format.din-element adăugat'
	return $template

return insert node $processed-template after .
