xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $corresp-value := concat('#', $context-node/@xml:id)

return delete nodes ($context-node | $context-node/following-sibling::tei:*[@corresp = $corresp-value])
