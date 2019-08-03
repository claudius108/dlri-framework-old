xquery version "3.0";

import module namespace dlr = "http://lingv.ro/ns/dlr/" at "../resources/xquery/dlr.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

(
    if (@type = ('abstr.', 'concr.', 'fig.', 'p. anal.', 'p. anal. cu', 'p. ext.'))
    then ()
    else (),
    if (parent::*[@type = 'grammatical-information'] and @type = 'unknown')
    then (
        delete nodes ./following-sibling::*
    )
    else (),
    if (@type = 'grammatical-information-type-for-adj-et-al')
    then (
        delete nodes ./following-sibling::*,
        insert node doc('../content-models/idno.xml') after .
    )
    else (),
    if (@type = 'grammatical-information-type-for-vb')
    then (
        delete nodes ./following-sibling::*,
        insert node doc('../content-models/grammatical-information-for-verb.xml') after .
    )
    else (),
    if (@type = 'grammatical-information-subtype-for-pl')
    then (
        delete nodes ./following-sibling::*,
        insert node doc('../content-models/grammatical-information-for-plural.xml') after .
    )
    else (),        
    if (@type = 'grammatical-information-subtype-for-case')
    then (
        delete nodes ./following-sibling::*,
        insert node doc('../content-models/grammatical-information-for-case.xml') after .
    )
    else (),
    if (@type = 'grammatical-information-subtype-for-fem-sg')
    then (
            delete nodes ./following-sibling::*,
            insert node doc('../content-models/grammatical-information-for-fem-sg.xml') after .
    )
    else (),
        
    if (parent::*/@cert)
    then (
    	delete nodes ./following-sibling::*[not(local-name() = 'note')],
    	let $cert-value :=
    		if (@type = (
    			'cuvântul.titlu-element.moştenit-etimon.neatestat',
    			'cuvântul.titlu-formație.internă-trimitere-V.'
    			)
    		)
    		then 'low'
    		else 'high'
    	return replace value of node parent::*/@cert with $cert-value
    )
    else ()
    ,
    if (@type = (
    	'cuvântul.titlu-element.moştenit-etimon.atestat',
    	'cuvântul.titlu-element.moştenit-etimon.neatestat'
    	)
    )
    then insert node $dlr:term-la-template after .	            
    else (),       
    if (@type = 'cuvântul.titlu-element.de.substrat')
    then insert nodes ($dlr:term-template, $dlr:term-template) after .  
    else (),  
    if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.prefix')
    then insert nodes ($dlr:term-prefix-template, $dlr:ptr-base-word-template) after .
    else (),
    if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.sufix')
    then insert nodes ($dlr:ptr-base-word-template, $dlr:term-sufix-template) after .
    else (),
    if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.prefix.şi.sufix')
    then insert nodes ($dlr:term-prefix-template, $dlr:ptr-base-word-template, $dlr:term-sufix-template) after .
    else (), 
    if (@type = 'cuvântul.titlu-formație.internă-compus-element.de.compunere.+.cuvânt.bază')
    then insert nodes ($dlr:ptr-component-element-template, $dlr:ptr-base-word-template) after .
    else (),
    if (@type = 'cuvântul.titlu-formație.internă-compus-cuvânt.bază.+.element.de.compunere')
    then insert nodes ($dlr:ptr-base-word-template, $dlr:ptr-component-element-template) after .
    else (), 
    if (@type = 'cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază')
    then insert nodes ($dlr:ptr-base-word-template, $dlr:ptr-base-word-template) after .
    else (),
    if (@type = 'cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină')
    then
		let $processed-template-1 :=
			copy $template := $dlr:term-la-template
			modify replace value of node $template/@type with 'latin-base'
			return $template
		let $processed-template-2 :=
			copy $template := $dlr:ptr-template
			modify replace value of node $template/@type with 'added-base'
			return $template				
		return insert nodes ($processed-template-1, $processed-template-2) after .
    else (),
    if (@type = 'cuvântul.titlu-formație.internă-compus-format.din')
    then (
            insert nodes (
            	$dlr:ptr-cuvântul.titlu-formație.internă-compus-format.din-bază-template
            	,
            	$dlr:ptr-cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-template
            ) after .
    )
    else (),    
    if (@type = 'cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente')
    then insert nodes ($dlr:ptr-template, $dlr:ptr-template) after .
    else (),       
    if (@type = 'unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor')
    then (
            insert nodes ($dlr:ptr-template, $dlr:bibl-template) after .
         )
    else (),  
    if (@type =
        (
            'unul.sau.mai.multe.sensuri-sensul-cf..etimon',
            'unul.sau.mai.multe.sensuri-sensul-cf..și.etimon'
        )
    )
    then (
            insert nodes (
            	$dlr:ptr-unul.sau.mai.multe.sensuri-sensul-template,
            	$dlr:ptr-unul.sau.mai.multe.sensuri-sensul-cf.-template
            ) after .
         )
    else (),
    if (@type = 
        (
        	'',
            'cuvântul.titlu-formație.internă-singular.refăcut.după.plural',
            'cuvântul.titlu-formație.internă-denumire.comercială',
            'cuvântul.titlu-element.necunoscut',
            'variantă-directă-sg..refăcut.după.plural',
            'variantă-directă-prin.etimologie.populară',
            'variantă-directă-prin.accidente.fonetice-afereză',
            'variantă-directă-prin.accidente.fonetice-proteză',
            'variantă-directă-prin.accidente.fonetice-sincopă',
            'variantă-directă-prin.accidente.fonetice-epenteză',
            'variantă-directă-prin.accidente.fonetice-anaptixă',
            'variantă-directă-prin.accidente.fonetice-apocopă',
            'variantă-directă-prin.accidente.fonetice-elidare',
            'variantă-directă-prin.accidente.fonetice-metateză',
            'variantă-directă-prin.accidente.fonetice-propagare',
            'variantă-directă-prin.accidente.fonetice-sinereză',
            'variantă-directă-refăcut.după.forma.articulată',
            'variantă-directă-refăcut.după.sg..art.',	            
            'variantă-directă-cu.schimbare.de.suf.',
            'cuvântul.titlu-loc.lat.',
            'cuvântul.titlu-formație.internă-onomatopee',
            'variantă-directă-etimon.variantă-prin.hiperurbanism'
        )
    )
    then ()
    else (),  
    if (@type =
            (
                'cuvântul.titlu-formație.internă-calc',
                'cuvântul.titlu-formație.internă-din.formulă.de.urare',
                'cuvântul.titlu-element.extern-împrumut-etimon.sigur',
                'cuvântul.titlu-etimon.neatestat.(reconstruit)',
                'element.extern-calc',
                'variantă-directă-din.lat.',
                'cuvântul.titlu-element.extern-trimitere-Cf.',
                'cuvântul.titlu-element.extern-trimitere-După'
            )
            or
	    	(
	    		starts-with(@type, 'variantă-directă-etimon.variantă')
	    		and @type != 'variantă-directă-etimon.variantă-prin.hiperurbanism'
	    	)            
    )
    then (
            insert node $dlr:term-template after .
    )
    else (),         
    if (@type = (
    		'cuvântul.titlu-formație.internă-trimitere-V.',
            'cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.plantei',
            'cuvântul.titlu-formație.internă-trimitere-De.la-n..pr.',
            'cuvântul.titlu-formație.internă-trimitere-De.la-numele.de.localitate',
            'cuvântul.titlu-formație.internă-trimitere-De.la-numele.sărbătorii.religioase',
            'cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.planetei',
            'cuvântul.titlu-formație.internă-prescurtare', 
			'cuvântul.titlu-formație.internă-derivat.regresiv',
    		'cuvântul.titlu-formație.internă-derivat.postverbal',
            'cuvântul.titlu-formație.internă-izolare-din.nume.de.localităţi',
            'cuvântul.titlu-formație.internă-izolare-prin.analiză.din.împrumuturi.ca',                    
            'cuvântul.titlu-formație.internă-izolare-prin.analiză.din.cuvinte.compuse.împrumutate',
            'cuvântul.titlu-formație.internă-format.după',
            'cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.primul.element.este',
            'cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.unul.dintre.elemente.este',
            'cuvântul.titlu-formație.internă-contragere',
            'cuvântul.titlu-formație.internă-formație.spontană.de.la',
            'cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la',
            'variantă-directă-singular.refăcut.după.pluralul',
            'variantă-directă-prin.apropiere.de',
            'variantă-directă-etimologie.populară.prin.apropiere.de',
            'variantă-directă-derivat.regresiv.de.la',
            'variantă-directă-prin.confuzie.cu',
            'variantă-directă-sub.influența',
            'cuvântul.titlu-formație.internă-trimitere-Din-etimon.atestat',
            'cuvântul.titlu-formație.internă-trimitere-Din-etimon.*'
    	)
    )
    then (
        insert node $dlr:ptr-template after .
    )
    else (), 
    if (starts-with(@type, 'una.sau.mai.multe.variante.lexicale-') and ends-with(@type, '-trimitere-cf..cuvânt'))
    then (
        insert nodes ($dlr:term-una.sau.mai.multe.variante.lexicale-template, $dlr:ptr-una.sau.mai.multe.variante.lexicale-cf.-template) after .
    )
    else (), 
    if (starts-with(@type, 'una.sau.mai.multe.variante.lexicale-') and ends-with(@type, '-trimitere-cf..izvor'))
    then (
        insert nodes ($dlr:term-una.sau.mai.multe.variante.lexicale-template, $dlr:bibl-template) after .
    )
    else (),
    if (@type = 'cuvântul.titlu-formație.internă-trimitere-Cf.')
    then insert node $dlr:ptr-cuvântul.titlu-formație.internă-trimitere-Cf.-template after .
    else ()   
)
