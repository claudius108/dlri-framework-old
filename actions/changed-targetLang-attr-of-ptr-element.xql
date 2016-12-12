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
	if (@type = 'unul.sau.mai.multe.sensuri-sensul-cf.' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlri:term-unul.sau.mai.multe.sensuri-sensul-cf.-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
	,
	if (@type = 'cuvântul.titlu-formație.internă-compus-format.din-bază' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlri:term-cuvântul.titlu-formație.internă-compus-format.din-bază-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()
	,
	if (@type = 'cuvântul.titlu-formație.internă-compus-format.din-element.adăugat' and @targetLang != 'ro')
	then
		let $processed-template :=
			copy $template := $dlri:term-cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-template
			modify replace value of node $template/@xml:lang with ./@targetLang
			return $template
			
		return replace node . with $processed-template
	else ()		
)	
