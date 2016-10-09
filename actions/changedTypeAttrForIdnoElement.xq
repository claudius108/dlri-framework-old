xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "../resources/xquery/dlri.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

(
    if (@n = 'tip-proces-semantic')
    then ()
    else (),
    if (@n = 'tip-unitate-semantică-subsumată' and @type = '')
    then (
        delete nodes ./following-sibling::tei:form[@type = 'unitate-semantică-subsumată'],
        replace value of node @type with 'unknown'
    )
    else (),
    if (@n = 'tip-unitate-semantică-subsumată' and @type != 'unknown')
    then (
        delete nodes ./following-sibling::tei:form[@type = 'unitate-semantică-subsumată']
        ,
        insert node <form xmlns="http://www.tei-c.org/ns/1.0" type="unitate-semantică-subsumată" /> after following-sibling::tei:idno[last()]
    )
    else (),    
    if (parent::*[@type = 'grammatical-information'] and @type = 'unknown')
    then (
        delete nodes ./following-sibling::*
    )
    else (),
    
    
    
    
    
    (
    	delete nodes ./following-sibling::*[not(local-name() = 'note')],
    	let $cert-value :=
    		if (@type = (
    			'cuvântul.titlu-element.moştenit-etimon.neatestat',
    			'cuvântul.titlu-formație.internă-trimitere-V.'
    			)
    		)
    		then 'low'
    		else 'high'
    	return replace value of node parent::*/@cert with $cert-value,     
	    if (@type = 'cuvântul.titlu-element.moştenit-etimon.atestat')
	    then
			let $processed-template :=
				copy $template := $dlri:term-template
				modify (
					replace value of node $template/@xml:lang with 'la'
				)
				return $template
			return insert node $processed-template after .	            
	    else (),
	    if (@type = 'cuvântul.titlu-element.moştenit-etimon.neatestat')
	    then
			let $processed-template :=
				copy $template := $dlri:term-template
				modify (
					replace value of node $template/@xml:lang with 'la'
				)
				return $template
			return insert node $processed-template after . 
	    else (),        
	    if (@type = 'cuvântul.titlu-element.de.substrat')
	    then insert nodes ($dlri:term-template, doc('../content-models/mentioned.xml')) after ./following-sibling::*[1]  
	    else (),  
	    if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.prefix')
	    then
			let $processed-template :=
				copy $template := $dlri:term-template
				modify replace value of node $template/@type with 'prefix'
				return $template
			return insert nodes ($processed-template, $dlri:ptr-template) after .
	    else (),
	    if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.sufix')
	    then
			let $processed-template :=
				copy $template := $dlri:term-template
				modify replace value of node $template/@type with 'sufix'
				return $template
			return insert nodes ($dlri:ptr-template, $processed-template) after .
	    else (),
	    if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.prefix.şi.sufix')
	    then
			let $processed-template-1 :=
				copy $template := $dlri:term-template
				modify replace value of node $template/@type with 'prefix'
				return $template
			let $processed-template-2 :=
				copy $template := $dlri:term-template
				modify replace value of node $template/@type with 'sufix'
				return $template
	        return insert nodes ($processed-template-1, $dlri:ptr-template, $processed-template-2) after .
	    else (), 
	    
	    
	    
	    
	    
	    
	    
	           
	    if (@type = 'cuvântul.titlu-formație.internă-compus-element.de.compunere.+.cuvânt.bază')
	    then (
	            insert nodes ($dlri:term-template, $dlri:term-template) after ./following-sibling::*[1],
	            replace value of node ./following-sibling::*[1]/@type with 'component-element',
	            replace value of node ./following-sibling::*[2]/@type with 'base'
	    )
	    else (),
	    
	    
	    
	    
	    
	    
	            
	    if (@type = 'cuvântul.titlu-formație.internă-compus-cuvânt.bază.+.element.de.compunere')
	    then (
	            insert nodes ($dlri:ptr-template, $dlri:ptr-template) after .
	    )
	    else (),              
	    if (@type = 'cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază')
	    then (
	            insert nodes ($dlri:term-template, $dlri:term-template) after ./following-sibling::*[1],
	            replace value of node ./following-sibling::*[1]/@type with 'base',
	            replace value of node ./following-sibling::*[2]/@type with 'base'
	    )
	    else (),
	    if (@type = 'cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină')
	    then (
	            insert nodes ($dlri:term-template, $dlri:term-template) after ./following-sibling::*[1],
	            replace value of node ./following-sibling::*[1]/@type with 'latin-base',
	            replace value of node ./following-sibling::*[2]/@type with 'added-base'
	    )
	    else (),
	    if (@type = 'cuvântul.titlu-formație.internă-compus-format.din')
	    then (
	            insert nodes ($dlri:term-template, $dlri:term-template) after ./following-sibling::*[1],
	            replace value of node ./following-sibling::*[1]/@type with 'cuvântul.titlu-formație.internă-compus-format.din-bază',
	            replace value of node ./following-sibling::*[2]/@type with 'cuvântul.titlu-formație.internă-compus-format.din-element adăugat'
	    )
	    else (),    
	    if (@type = 'cuvântul.titlu-formație.internă-trimitere-V.')
	    then (
	            insert nodes $dlri:ptr-template after ./following-sibling::*[1]
	         )
	    else (),        
	    if (@type = 'cuvântul.titlu-formație.internă-trimitere-Cf.')
	    then (
	            insert nodes $dlri:ptr-template after ./following-sibling::*[1]
	         )
	    else (),
	    if (@type = 'cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente')
	    then (
	            insert nodes ($dlri:term-template, $dlri:term-template, $dlri:term-template, $dlri:term-template) after ./following-sibling::*[1],
	            replace value of node ./following-sibling::*[1]/@type with 'contaminated-element',
	            replace value of node ./following-sibling::*[2]/@type with 'alternative-contaminated-element',
	            replace value of node ./following-sibling::*[3]/@type with 'contamination-element',
	            replace value of node ./following-sibling::*[4]/@type with 'alternative-contamination-element'
	    )
	    else (),
	    if (@type = 'cuvântul.titlu-etimon.neatestat.(reconstruit)')
	    then (
	            insert node $dlri:term-template after ./following-sibling::*[1]
	    )
	    else (),       
	    if (@type = 'cuvântul.titlu-element.extern-trimitere')
	    then (
	            insert node doc('../content-models/mentioned.xml') after ./following-sibling::*[1]
	         )
	    else (),    
	    if (@type = 'unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor')
	    then (
	            insert nodes ($dlri:ptr-template, $dlri:bibl-template) after ./following-sibling::*[1]
	         )
	    else (),  
	    if (@type =
	        (
	            'unul.sau.mai.multe.sensuri-sensul-cf..etimon',
	            'unul.sau.mai.multe.sensuri-sensul-cf..și.etimon'
	        )
	    )
	    then (
	            insert nodes ($dlri:ptr-template, $dlri:term-template) after ./following-sibling::*[1]
	         )
	    else (),        
	    if (@type = 
	        (
	            'cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.primul.element.este',
	            'cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.unul.dintre.elemente.este'        
	        )
	    )
	    then (
	    		insert node $dlri:term-template after ./following-sibling::*[1],
	    		replace value of node ./following-sibling::*[1]/@type with 'contamination-element'
	    )
	    else (),
	    if (@cert and @type = 
	        (
	        	'',
	            'variantă-directă-cu.schimbare.de.suf.',
	            'variantă-directă-refăcut.după.forma.articulată',
	            'variantă-directă-refăcut.după.sg..art.',
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
	            'variantă-directă-prin.accidente.fonetice-sinereză'
	        )
	    )
	    then ()
	    else (),  
	    if (@type =
	            (
	                'cuvântul.titlu-formație.internă-derivat.regresiv',
	                'cuvântul.titlu-formație.internă-derivat.postverbal',                
	                'cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.plantei',
	                'cuvântul.titlu-formație.internă-trimitere-De.la-n..pr.',
	                'cuvântul.titlu-formație.internă-trimitere-De.la-numele.de.localitate',
	                'cuvântul.titlu-formație.internă-trimitere-De.la-numele.sărbătorii.religioase',
	                'cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.planetei',
	                'cuvântul.titlu-formație.internă-trimitere-Din-etimon.atestat',
	                'cuvântul.titlu-formație.internă-trimitere-Din-etimon.*',
	                'cuvântul.titlu-formație.internă-prescurtare',
	                'cuvântul.titlu-formație.internă-calc',
	                'cuvântul.titlu-formație.internă-onomatopee',
	                'cuvântul.titlu-formație.internă-contragere',
	                'cuvântul.titlu-formație.internă-izolare-prin.analiză.din.împrumuturi.ca',                    
	                'cuvântul.titlu-formație.internă-izolare-prin.analiză.din.cuvinte.compuse.împrumutate',
	                'cuvântul.titlu-formație.internă-izolare-din.nume.de.localităţi',                    
	                'cuvântul.titlu-formație.internă-singular.refăcut.după.plural',
	                'cuvântul.titlu-formație.internă-formație.onomatopeică',
	                'cuvântul.titlu-formație.internă-formație.spontană.de.la',
	                'cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la',
	                'cuvântul.titlu-formație.internă-din.formulă.de.urare',
	                'cuvântul.titlu-formație.internă-format.după',
	                'cuvântul.titlu-formație.internă-denumire.comercială',
	                'cuvântul.titlu-element.extern-împrumut-etimon.sigur',
	                'cuvântul.titlu-etimon.neatestat.(reconstruit)',
	                'cuvântul.titlu-element.extern-calc',
	                'cuvântul.titlu-element.necunoscut',
	                'variantă-directă-etimon.variantă-atestat',
	                'variantă-directă-etimon.variantă-reconstruit',                
	                'variantă-directă-singular.refăcut.după.pluralul',
	                'variantă-directă-prin.apropiere.de',
	                'variantă-directă-prin.derivare.cu.suf.',
	                'variantă-directă-sub.influența',
	                'variantă-directă-etimologie.populară.prin.apropiere.de',
	                'variantă-directă-din.lat.',
	                'variantă-directă-derivat.regresiv.de.la',
	                'variantă-directă-prin.confuzie.cu'
	            )
	    )
	    then (
	            insert node $dlri:term-template after ./following-sibling::*[1]
	    )
	    else (),         
	    if (starts-with(@type, 'una.sau.mai.multe.variante.lexicale-') and ends-with(@type, '-trimitere-cf..cuvânt'))
	    then (
	        insert node $dlri:ptr-template after ./following-sibling::*[1]
	    )
	    else (), 
	    if (starts-with(@type, 'una.sau.mai.multe.variante.lexicale-') and ends-with(@type, '-trimitere-cf..izvor'))
	    then (
	        insert node $dlri:bibl-template after ./following-sibling::*[1]
	    )
	    else ()
	 ),
    
    
    
    
    
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
    if (@type = 'grammatical-information-subtype-for-gender')
    then (
            delete nodes ./following-sibling::*,
            insert node doc('../content-models/grammatical-information-for-gender.xml') after .
    )
    else ()
)
