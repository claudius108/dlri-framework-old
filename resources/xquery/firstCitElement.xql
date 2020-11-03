xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $context-node := .

return
    if ($context-node/child::*)
    then
        let $delimiter := (dlr:get-last-def-component($context-node) | $context-node/tei:xr[@type = 'syn' and not(@corresp)] | $context-node/tei:term[@xml:lang = 'la'] | $context-node/tei:xr[@type = ('asoc', 'analog')] | $context-node/tei:ptr[@type = 'trimitere'])[last()]
        
        return insert node $dlr:cit-template after $delimiter
    else insert node $dlr:cit-template into $context-node
