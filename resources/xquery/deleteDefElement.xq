xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $associated-element-names := ("usg", "ptr")
let $following-def-element := following-sibling::tei:def[1]

return
	if (exists($following-def-element))
	then delete nodes (following-sibling::tei:*[. << $following-def-element] | .)
	else delete nodes (following-sibling::tei:ptr | following-sibling::tei:usg | .)
