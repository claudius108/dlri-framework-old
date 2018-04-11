xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template :=
	copy $template := $dlri:ptr-template
	modify replace value of node $template//@type with 'asoc'
	return $template

return
	if (local-name() = 'ptr')
	then insert node $processed-template after .
	else
		let $current-def := .
		let $next-def := $current-def/following-sibling::tei:def
		let $current-def-children := $next-def/preceding-sibling::tei:*[preceding-sibling::tei:def]
		
		
		return insert node $processed-template after ($current-def | $current-def-children)[last()]		
	
	
	
	(: insert node $processed-template after (following-sibling::tei:ptr[@type = ('analog', 'syn', 'asoc')] | .)[last()] :)
