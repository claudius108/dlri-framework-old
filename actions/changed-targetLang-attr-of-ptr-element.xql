xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "../resources/xquery/dlri.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

(
	if (@type = 'una.sau.mai.multe.variante.lexicale-cf.' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlri:term-una.sau.mai.multe.variante.lexicale-cf.-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
	,
	if (@type = 'unul.sau.mai.multe.sensuri-sensul-cf..etimon-cf.' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlri:term-unul.sau.mai.multe.sensuri-sensul-cf..etimon-cf.-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
)	
