xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "../resources/xquery/dlr.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

(
	if (@type = 'una.sau.mai.multe.variante.lexicale-cf.' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlr:term-una.sau.mai.multe.variante.lexicale-cf.-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
	,
	if (@type = 'formație.internă-compus-format.din-bază' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlr:term-formație.internă-compus-format.din-bază-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
	,
	if (@type = 'formație.internă-compus-format.din-element.adăugat' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlr:term-formație.internă-compus-format.din-element.adăugat-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
	,
	if (@type = 'formație.internă-trimitere-Cf.' and @targetLang != 'ro')
	then replace node . with $dlr:term-formație.internă-trimitere-Cf.-template
	else ()
)	
