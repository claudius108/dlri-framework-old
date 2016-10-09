xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template :=
	copy $template := $dlri:ptr-template
	modify replace value of node $template//@type with 'antonim'
	return $template

return
	if (local-name() = 'ptr')
	then insert node $processed-template after .
	else insert node $processed-template after (following-sibling::tei:ptr[@type = ('analog', 'syn', 'asoc', 'antonim')] | .)[last()]
