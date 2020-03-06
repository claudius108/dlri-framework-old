xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $current-element-name := local-name()

return
	switch ($current-element-name)
	case "sense"
	return insert node $dlr:gramGrp-template as first into .	
	case "gramGrp" return insert node $dlr:gramGrp-template after .
	case "etym" return insert node $dlr:gramGrp-template as last into .
	default return ()
