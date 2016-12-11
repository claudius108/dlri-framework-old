xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "../resources/xquery/dlri.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

(
	if (@type = 'una.sau.mai.multe.variante.lexicale-cf.' and @xml:lang = 'ro')
	then replace node . with $dlri:ptr-una.sau.mai.multe.variante.lexicale-cf.-template
	else ()
	,
	if (@type = 'unul.sau.mai.multe.sensuri-sensul-cf..etimon-cf.' and @xml:lang = 'ro')
	then replace node . with $dlri:ptr-unul.sau.mai.multe.sensuri-sensul-cf..etimon-cf.-template
	else ()
)	
