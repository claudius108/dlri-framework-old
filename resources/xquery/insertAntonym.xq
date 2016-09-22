xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $processed-template :=
	copy $template := doc('../../content-models/ptr.xml')
	modify replace value of node $template//@type with 'antonim'
	return $template

return
	if (local-name() = 'ptr')
	then insert node $processed-template after .
	else insert node $processed-template after (following-sibling::tei:ptr[@type = ('analog', 'syn', 'asoc', 'antonim')] | .)[last()]
