xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .
let $last-def-element := dlr:get-last-def-component($context-node)

return insert node $dlr:term-la-template after $last-def-element
