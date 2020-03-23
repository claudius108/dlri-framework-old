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
    			'element.moştenit-etimon.neatestat',
    			'formație.internă-trimitere-V.'
    			)
    		)
    		then 'low'
    		else 'high'
    	return replace value of node parent::*/@cert with $cert-value
    )
    else ()
    ,
    if (@type = (
    	'element.moştenit-etimon.atestat',
    	'element.moştenit-etimon.neatestat'
    	)
    )
    then insert node $dlr:term-la-template after .	            
    else (),       
    if (@type = 'element.de.substrat')
    then insert nodes ($dlr:term-template, $dlr:term-template) after .  
    else (),  
    if (@type = 'formație.internă-derivat-cu.prefix')
    then insert nodes ($dlr:term-prefix-template, $dlr:ptr-base-word-template) after .
    else (),
    if (@type = 'formație.internă-derivat-cu.sufix')
    then insert nodes ($dlr:ptr-base-word-template, $dlr:term-sufix-template) after .
    else (),
    if (@type = 'formație.internă-derivat-nume.propriu.cu.sufix')
    then insert nodes ($dlr:term-template, $dlr:term-sufix-template) after .
    else (),    
    if (@type = 'formație.internă-derivat-cu.prefix.şi.sufix')
    then insert nodes ($dlr:term-prefix-template, $dlr:ptr-base-word-template, $dlr:term-sufix-template) after .
    else (), 
    if (@type = 'formație.internă-compus-element.de.compunere.+.cuvânt.bază')
    then insert nodes ($dlr:ptr-component-element-template, $dlr:ptr-base-word-template) after .
    else (),
    if (@type = 'formație.internă-compus-cuvânt.bază.+.element.de.compunere')
    then insert nodes ($dlr:ptr-base-word-template, $dlr:ptr-component-element-template) after .
    else (), 
    if (@type = 'formație.internă-compus-din.mai.multe.cuvinte.de.bază')
    then insert nodes ($dlr:ptr-base-word-template, $dlr:ptr-base-word-template) after .
    else (),
    if (@type = 'formație.internă-compus-formație.savantă.din.latină')
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
    if (@type = 'formație.internă-compus-format.din')
    then (
            insert nodes (
            	$dlr:ptr-formație.internă-compus-format.din-bază-template
            	,
            	$dlr:ptr-formație.internă-compus-format.din-element.adăugat-template
            ) after .
    )
    else (),    
    if (@type = 'formație.internă-contaminare-cu.două.sau.mai.multe.elemente')
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
            insert node $dlr:ptr-unul.sau.mai.multe.sensuri-sensul-cf.-template after .
         )
    else (),
    if (@type = 
        (
        	'',
            'formație.internă-singular.refăcut.după.plural',
            'formație.internă-denumire.comercială',
            'element.necunoscut',
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
            'loc.lat.',
            'formație.internă-onomatopee',
            'variantă-directă-etimon.variantă-prin.hiperurbanism'
        )
    )
    then ()
    else (),  
    if (@type =
            (
                'formație.internă-calc',
                'formație.internă-din.formulă.de.urare',
                'element.extern-împrumut-etimon.sigur',
                'etimon.neatestat.(reconstruit)',
                'element.extern-calc',
                'variantă-directă-din.lat.',
                'element.extern-trimitere-Cf.',
                'element.extern-trimitere-După',
                'cuvânt.internațional'
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
    		'formație.internă-trimitere-V.',
    		'formație.internă-derivat.îndepărtat',
            'formație.internă-trimitere-De.la-numele.ştiințific.al.plantei',
            'formație.internă-trimitere-De.la-n..pr.',
            'formație.internă-trimitere-De.la-numele.de.localitate',
            'formație.internă-trimitere-De.la-numele.sărbătorii.religioase',
            'formație.internă-trimitere-De.la-numele.ştiințific.al.planetei',
            'formație.internă-prescurtare', 
			'formație.internă-derivat.regresiv',
    		'formație.internă-derivat.postverbal',
            'formație.internă-izolare-din.nume.de.localităţi',
            'formație.internă-izolare-prin.analiză.din.împrumuturi.ca',                    
            'formație.internă-izolare-prin.analiză.din.cuvinte.compuse.împrumutate',
            'formație.internă-format.după',
            'formație.internă-contaminare-cu.un.element-în.care.primul.element.este',
            'formație.internă-contaminare-cu.un.element-în.care.unul.dintre.elemente.este',
            'formație.internă-contragere',
            'formație.internă-formație.spontană.de.la',
            'formație.internă-prin.figură.etimologică.de.la',
            'variantă-directă-singular.refăcut.după.pluralul',
            'variantă-directă-prin.apropiere.de',
            'variantă-directă-etimologie.populară.prin.apropiere.de',
            'variantă-directă-derivat.regresiv.de.la',
            'variantă-directă-prin.confuzie.cu',
            'variantă-directă-sub.influența',
            'formație.internă-trimitere-Din-etimon.atestat',
            'formație.internă-trimitere-Din-etimon.*'
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
    if (@type = 'una.sau.mai.multe.variante.lexicale-variante.cu-trimitere-cf..izvor')
    then (
        insert nodes ($dlr:term-una.sau.mai.multe.variante.lexicale-template, $dlr:bibl-template) after .
    )
    else (),    
    if (@type = ('una.sau.mai.multe.variante.lexicale-variante.de.tipul-trimitere-cf..izvor', 'una.sau.mai.multe.variante.lexicale-variantă-trimitere-cf..izvor'))
    then (
        insert node $dlr:bibl-template after .
    )
    else (),
    if (@type = 'formație.internă-trimitere-Cf.')
    then insert node $dlr:ptr-formație.internă-trimitere-Cf.-template after .
    else ()   
)
