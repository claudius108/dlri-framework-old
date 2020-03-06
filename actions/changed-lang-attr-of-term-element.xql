xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "../resources/xquery/dlr.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

(
	if (@type = 'una.sau.mai.multe.variante.lexicale-cf.' and @xml:lang = 'ro')
	then replace node . with $dlr:ptr-una.sau.mai.multe.variante.lexicale-cf.-template
	else ()
	,
	if (@type = 'unul.sau.mai.multe.sensuri-sensul-cf.' and @xml:lang = 'ro')
	then replace node . with $dlr:ptr-unul.sau.mai.multe.sensuri-sensul-cf.-template
	else ()
	,
	if (@type = 'formație.internă-compus-format.din-bază' and @xml:lang = 'ro')
	then replace node . with $dlr:ptr-formație.internă-compus-format.din-bază-template
	else ()
	,
	if (@type = 'formație.internă-compus-format.din-element.adăugat' and @xml:lang = 'ro')
	then replace node . with $dlr:ptr-formație.internă-compus-format.din-element.adăugat-template
	else ()
	,
	if (@type = 'formație.internă-trimitere-Cf.' and @xml:lang = 'ro')
	then replace node . with $dlr:ptr-formație.internă-trimitere-Cf.-template
	else ()	
)	
