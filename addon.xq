xquery version "3.0";

import module "http://expath.org/ns/user-agent/";

declare namespace ua-dt = "http://expath.org/ns/user-agent/datatype/";
declare namespace oxy = "http://oxygenxml.com/extensions/author/";

declare variable $ua:document := /;

declare variable $languages-template as element() :=
	<select data-ua-ref="{@xml:lang}" contenteditable="false">
	    <option xml:id="" label="" value="" />
	    <option xml:id="sq" label="alb." value="sq" />
	    <option xml:id="rup" label="arom." value="rup" />
	    <option xml:id="bg" label="bg." value="bg" />
	    <option xml:id="ca" label="cat." value="ca" />
	    <option xml:id="cs" label="ceh." value="cs" />
	    <option xml:id="hr" label="cr." value="hr" />
	    <option xml:id="dlm" label="dalm." value="dlm" />
	    <option xml:id="he" label="ebr." value="he" />
	    <option xml:id="rm-puter-vallader" label="engad." value="rm-puter-vallader" />
	    <option xml:id="en" label="engl." value="en" />
	    <option xml:id="eo" label="esper." value="eo" />
	    <option xml:id="fr" label="fr." value="fr" />
	    <option xml:id="fur" label="friul." value="fur" />
	    <option xml:id="de" label="germ." value="de" />
	    <option xml:id="grc" label="gr." value="grc" />
	    <option xml:id="ruo" label="istr." value="ruo" />
	    <option xml:id="it" label="it." value="it" />
	    <option xml:id="la" label="lat." value="la" />
	    <option xml:id="la-x-popular" label="lat. pop." value="la-x-popular" />
	    <option xml:id="la-x-medieval" label="lat. mediev." value="la-x-medieval" />
	    <option xml:id="lt" label="lituan." value="lt" />
	    <option xml:id="hu" label="magh." value="hu" />
	    <option xml:id="ruq" label="megl." value="ruq" />
	    <option xml:id="gre" label="m. gr." value="gre" />
	    <option xml:id="el" label="ngr." value="el" />
	    <option xml:id="pl" label="pol." value="pl" />
	    <option xml:id="pt" label="port." value="pt" />
	    <option xml:id="roa" label="prov." value="roa" />
	    <option xml:id="rm" label="retorom." value="rm" />
	    <option xml:id="ro" label="rom." value="ro" />
	    <option xml:id="ru" label="rus." value="ru" />
	    <option xml:id="sxu" label="săs." value="sxu" />
	    <option xml:id="sc" label="sard." value="sc" />
	    <option xml:id="sr" label="sb." value="sr" />
	    <option xml:id="scn" label="sicil." value="scn" />
	    <option xml:id="" label="sl." value="sl." />
	    <option xml:id="" label="slavon." value="slavon." />
	    <option xml:id="sl" label="slov." value="sl" />
	    <option xml:id="es" label="sp." value="es" />
	    <option xml:id="tt" label="tăt." value="tt" />
	    <option xml:id="tr" label="tc." value="tr" />
	    <option xml:id="tr-x-dialect" label="tc. dial." value="tr-x-dialect" />
	    <option xml:id="rom" label="ţig." value="rom" />
	    <option xml:id="uk" label="ucr." value="uk" />
	    <option xml:id="dlm-x-vegliot" label="vegl." value="dlm-x-vegliot" />
	    <option xml:id="" label="v. sl." value="v. sl." />            
	</select>
;

declare variable $bibl-template as element() :=
    <bibl xmlns="http://www.tei-c.org/ns/1.0" type="unknown">
        <ptr target="unknown" />
        <date />
        <citedRange />
    </bibl>
;

declare variable $cit-template as element() :=
    <cit xmlns="http://www.tei-c.org/ns/1.0">
        <quote />
        {$bibl-template}
    </cit>
;

declare variable $def-template as element() :=
    <def xmlns="http://www.tei-c.org/ns/1.0" n="" />
;

declare variable $sense-template as element() :=
    <sense xmlns="http://www.tei-c.org/ns/1.0" xml:id="id">
        <idno n="" type="level-label" />
        <idno n="tip-unitate-semantică-subsumată" type="unknown" />
        {$def-template}
        {$cit-template}
    </sense>
;

declare variable $term-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="unknown" subtype="unknown" />
;

declare variable $collocations-template as element() :=
    <select data-ua-ref="{@type}" style="width: 40px;" multiple="multiple" data-ua-appearance="oxy:popupWithMultipleSelection">
        <option label="proverb" value="proverb" />
        <option label="zicătoare" value="saying" />
        <option label="cimilitură" value="riddle" />
        <option label="ghicitoare" value="sibyl" />
        <option label="sintagmă" value="syntagma" />
        <option label="expresie" value="phrase" />
        <option label="compus" value="compound" />
        <option label="loc. adj." value="adjectival-locution" />
        <option label="loc. adv." value="adverbial-locution" />
        <option label="loc. prep." value="prepositional-locution" />
        <option label="loc. conj." value="conjunctional-locution" />
        <option label="loc. vb." value="verbal-locution" />
    </select>
;

declare variable $gr-minuscule as xs:string := "α,β,γ,δ,ε,ζ,η,θ,ι,κ,λ,μ,ν,ξ,ο,π,ρ,ς,σ,τ,υ,φ,χ,ψ,ω";

declare variable $ro-vocale-minuscule as xs:string := "á,é,í,ó,ú,ắ,ấ,î́";

declare variable $ro-vocale-majuscule as xs:string := "Á,É,Í,Ó,Ú,Ắ,Ấ,Î";

ua:action(
    "insertDefElement",
    map { 
        "name" := "Definiție",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertDefElement.xq")   
),
ua:action(
    "deleteDefElement",
    map { 
        "name" := "Ștergere definiție",
        "smallIconPath" := "../../resources/images/delete.png"
    }, 
    oxy:execute-xquery-update-script("resources/xquery/deleteDefElement.xq")  
),
ua:action(
    "insertCitElement",
    map { 
        "name" := "Atestare",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertCitElement.xq")
),
ua:action(
    "deleteCurrentElement",
    map { 
        "name" := "Ștergere",
        "smallIconPath" := "../../resources/images/delete.png"       
    },   
    oxy:execute-xquery-update-script("resources/xquery/deleteCurrentElement.xq")
),
ua:action(
    "addFirstLexicalVariant",
    map { 
        "name" := "Variantă lexicală"        
    }, 
    oxy:execute-xquery-update-script("resources/xquery/addFirstLexicalVariant.xq")  
),
ua:action(
    "addLexicalVariant",
    map { 
        "name" := "Variantă lexicală",
        "smallIconPath" := "../../resources/images/add.png"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/addLexicalVariant.xq")
),
ua:action(
    "addEtymElement",
    map { 
        "name" := "Etimologie",
        "smallIconPath" := "../../resources/images/add.png"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/addEtymElement.xq")
),
ua:action(
    "insertAuthorElement",
    map { 
        "name" := "Redactor",
        "smallIconPath" := "../../resources/images/add.png"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/insertAuthorElement.xq")
),
ua:action(
    "insertEditorElement",
    map { 
        "name" := "Revizor",
        "smallIconPath" := "../../resources/images/add.png"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/insertEditorElement.xq")
),
ua:action(
    "insertFirstUsgElement",
    map { 
        "name" := "Indicație folosire"       
    },
    oxy:execute-xquery-update-script("resources/xquery/insertFirstUsgElement.xq")
),
ua:action(
    "insertUsgElement",
    map { 
        "name" := "Indicație folosire",
        "smallIconPath" := "../../resources/images/add.png"        
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertUsgElement.xq")  
),
ua:action(
    "insertFirstBiblElement",
    map { 
        "name" := "Izvor",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    (
        if (count(syll | pron | pRef | usg | gen | case | ptr | mood | tns
                        | per | form[@type = 'details-for-grammatical-information-for-verb']
                        | stress | oVar | form[@type = 'flexionar-variant']
                        | form[contains(' unknown-accentuation accentuation-variant ', @type)]
                        | form[@type = 'pronunciation'] | form[@type = 'writing']
                        | form[@type = 'abbreviation'] | form[@type = 'grammatical-information'] | mentioned) = 0)
        then (insert node $bibl-template as first into .)
        else (),
        if (count(syll | pron | pRef | usg | gen | case | ptr | mood | tns
                        | per | form[@type = 'details-for-grammatical-information-for-verb']
                        | stress | oVar | form[@type = 'flexionar-variant']
                        | form[contains(' unknown-accentuation accentuation-variant ', @type)]
                        | form[@type = 'pronunciation'] | form[@type = 'writing']
                        | form[@type = 'abbreviation'] | form[@type = 'grammatical-information'] | mentioned) gt 0)
                        then (insert node $bibl-template after (syll | pron | pRef | usg | gen | case | ptr | mood | tns
                        | per | form[@type = 'details-for-grammatical-information-for-verb']
                        | stress | oVar | form[@type = 'flexionar-variant']
                        | form[contains(' unknown-accentuation accentuation-variant ', @type)]
                        | form[@type = 'pronunciation'] | form[@type = 'writing']
                        | form[@type = 'abbreviation'] | form[@type = 'grammatical-information'] | mentioned)[last()])
        else ()
    )      
),
ua:action(
    "insertBiblElement",
    map { 
        "name" := "Izvor",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    (
        if (count(parent::*/(stress | oVar)) > 0)
        then (insert node $bibl-template after parent::*/(stress | usg | oVar)[last()])
        else (),
        if (count(parent::*/(stress | oVar)) = 0)
        then (insert node $bibl-template after .)
        else ()
    )      
),
ua:action(
    "insertSynonym",
    map { 
        "name" := "Sinonim",
        "smallIconPath" := "../../resources/images/add.png"
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertSynonym.xq")  
),
ua:action(
    "insertAnalogy",
    map { 
        "name" := "Analogie",
        "smallIconPath" := "../../resources/images/add.png"        
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertAnalogy.xq")  
),
ua:action(
    "insertAssociation",
    map { 
        "name" := "Asociație",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertAssociation.xq")
),
ua:action(
    "insertAntonym",
    map { 
        "name" := "Antonim",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertAntonym.xq")
),
ua:action(
    "insertReference",
    map { 
        "name" := "Trimitere"        
    },   
    insert node doc('content-models/reference.xml') after (usg | ptr[@type = 'trimitere'] | def)[last()]
),
ua:action(
    "addGramGrp",
    map { 
        "name" := "Cat. gram.",
        "smallIconPath" := "../../resources/images/add.png"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addGramGrp.xq")
),
ua:action(
    "addFirstAccentuationSection",
    map { 
        "name" := "Accentuare"        
    },
	oxy:execute-xquery-update-script("resources/xquery/addFirstAccentuationSection.xq")    
),
ua:action(
    "addAccentuationSection",
    map { 
        "name" := "Accentuare",
        "smallIconPath" := "../../resources/images/add.png"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addAccentuationSection.xq")   
),
ua:action(
    "addFirstArticulationSection",
    map { 
        "name" := "Articulare"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstArticulationSection.xq")
),
ua:action(
    "addArticulationSection",
    map { 
        "name" := "Articulare",
        "smallIconPath" := "../../resources/images/add.png"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/addArticulationSection.xq")
),
ua:action(
    "addFirstPronunciationSection",
    map { 
        "name" := "Pronunțare"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstPronunciationSection.xq")
),
ua:action(
    "addPronunciationSection",
    map { 
        "name" := "Pronunțare",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    oxy:execute-xquery-update-script("resources/xquery/addPronunciationSection.xq")
),
ua:action(
    "addFirstGrammaticalInformationSection",
    map { 
        "name" := "Indicații gramaticale"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstGrammaticalInformationSection.xq")
),
ua:action(
    "addGrammaticalInformationSection",
    map { 
        "name" := "Indicații gramaticale",
        "smallIconPath" := "../../resources/images/add.png"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addGrammaticalInformationSection.xq")
),
ua:action(
    "addFirstSyllabationElement",
    map { 
        "name" := "Silabație hiat"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/addFirstSyllabationElement.xq")
),
ua:action(
    "addSyllabationElement",
    map { 
        "name" := "Silabație hiat",
        "smallIconPath" := "../../resources/images/add.png"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/addSyllabationElement.xq")
),
ua:action(
    "addFirstPronElement",
    map { 
        "name" := "Pron. cuvânt străin"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstPronElement.xq")
),
ua:action(
    "addPronElement",
    map { 
        "name" := "Pron. cuvânt străin",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    oxy:execute-xquery-update-script("resources/xquery/addPronElement.xq")
),
ua:action(
    "addFirstPronunciationReferenceElement",
    map { 
        "name" := "Pronunţat şi"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstPronunciationReferenceElement.xq")
),
ua:action(
    "addPronunciationReferenceElement",
    map { 
        "name" := "Pronunţat şi",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    oxy:execute-xquery-update-script("resources/xquery/addPronunciationReferenceElement.xq")
),
ua:action(
    "addFirstWritingSection",
    map { 
        "name" := "Scriere"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstWritingSection.xq")
),
ua:action(
    "addWritingSection",
    map { 
        "name" := "Scriere",
        "smallIconPath" := "../../resources/images/add.png"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addWritingSection.xq")
),
ua:action(
    "addFirstAbbreviationSection",
    map { 
        "name" := "Abreviere"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstAbbreviationSection.xq")
),
ua:action(
    "addAbbreviationSection",
    map { 
        "name" := "Abreviere",
        "smallIconPath" := "../../resources/images/add.png"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addAbbreviationSection.xq")
),
ua:action(
    "addGrammaticalInformationForPluralSection",
    map { 
        "name" := "Plural",
        "smallIconPath" := "../../resources/images/add.png"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addGrammaticalInformationForPluralSection.xq")
),
ua:action(
    "addFirstGenElement",
    map { 
        "name" := "Gen"        
    },   
    oxy:execute-xquery-update-script("resources/xquery/addFirstGenElement.xq")
),
ua:action(
    "addGenElement",
    map { 
        "name" := "Gen",
        "smallIconPath" := "../../resources/images/add.png"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addGenElement.xq")
),
ua:action(
    "insertFirstSenseNumber",
    map { 
        "name" := "Nr. de sens"       
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertFirstSenseNumber.xq")  
),
ua:action(
    "insertSenseNumber",
    map { 
        "name" := "Nr. de sens",
        "smallIconPath" := "../../resources/images/add.png"        
    },
    oxy:execute-xquery-update-script("resources/xquery/insertSenseNumber.xq")
),
ua:action(
    "addGrammaticalInformationForCaseSection",
    map { 
        "name" := "Plural",
        "smallIconPath" := "../../resources/images/add.png"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addGrammaticalInformationForCaseSection.xq")   
),
ua:action(
    "addGrammaticalInformationForVerbSection",
    map { 
        "name" := "Verb",
        "smallIconPath" := "../../resources/images/add.png"
    },   
    insert node doc('content-models/grammatical-information-for-verb.xml') after .
),
ua:action(
    "insertFirstStressElement",
    map { 
        "name" := "Var. acc."      
    },   
    insert node doc('content-models/stress.xml') after form[@type = 'details-for-grammatical-information-for-verb']
),
ua:action(
    "insertStressElement",
    map { 
        "name" := "Var. acc.",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    insert node doc('content-models/stress.xml') after .
),
ua:action(
    "insertFirstoVarElement",
    map { 
        "name" := "Var. de scriere"
    },   
    insert node doc('content-models/oVar.xml') after (gramGrp | usg | ptr | gen | bibl | abbr)[last()]
),
ua:action(
    "insertoVarElement",
    map { 
        "name" := "Var. de scriere",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    insert node doc('content-models/oVar.xml') after .
),
ua:action(
    "addGrammaticalInformationForGenderSection",
    map { 
        "name" := "Gen",
        "smallIconPath" := "../../resources/images/add.png"
    },   
    insert node doc('content-models/grammatical-information-for-gender.xml') after .
),
ua:action(
    "boldAnnotator",
    map { 
        "name" := "Bold",
        "accelerator" := "ctrl B"        
    },   
    replace node . with <hi xmlns="http://www.tei-c.org/ns/1.0" rend="bold">{.}</hi>
),
ua:action(
    "searchBibliographicReferences",
    map { 
        "name" := "Căutare"       
    },   
    oxy:execute-xquery-script("resources/xquery/get-bibliographic-references.xq")
),
ua:action(
    "searchHeadwordReferences",
    map { 
        "name" := "Căutare"       
    },   
    oxy:execute-xquery-script("resources/xquery/get-headword-references.xq")
),
ua:action(
    "changedValueAttrForFormElement",
    map { 
        "name" := "changedValueAttrForFormElement"
    }, 
    (
        if (@type = 'accentuation-variant')
        then (insert node doc('content-models/stress.xml') as first into .)
        else ()
        ,
        if (@type = 'unknown-accentuation')
        then (delete nodes element())
        else ()        
    )
),
ua:action(
    "changedValueAttrForPosElement",
    map { 
        "name" := "changedValueAttrForPosElement"
    }, 
    (
        if (@value = ('', 'adv.', 'conj.', 'interj.', 'prep.'))
        then (delete nodes parent::*/element()[position() > 1])
        else (),
        if (@value = 'adj.')
        then
            (
                delete nodes parent::*/element()[position() > 1],
                insert nodes (doc('content-models/subc.xml'), doc('content-models/gen.xml'), doc('content-models/number.xml'),
                    doc('content-models/case.xml')) as last into parent::*
            )
        else (),
        if (@value = ('art.', 'num.', 'pron.'))
        then
            (
                delete nodes parent::*/element()[position() > 1],
                insert node doc('content-models/subc.xml') as last into parent::*
            )
        else (),
        if (@value = 's.')
        then
            (
                delete nodes parent::*/element()[position() > 1],
                insert nodes (doc('content-models/gen.xml'), doc('content-models/number.xml'), doc('content-models/case.xml'), doc('content-models/name.xml')) as last into parent::*
            )
        else (),
        if (@value = 'subst.')
        then
            (
                delete nodes parent::*/element()[position() > 1],
                insert node doc('content-models/number.xml') as last into parent::*
            )
        else (),
        if (@value = 'vb.')
        then
            (
                delete nodes parent::*/element()[position() > 1],
                insert nodes (doc('content-models/iType.xml'), doc('content-models/subc.xml')) as last into parent::*
            )
        else ()
    )
),
ua:action(
    "changedValueAttrForSubcElement",
    map { 
        "name" := "changedValueAttrForSubcElement"     
    }, 
    (
        if (@value = ('adj.-empty', 'adj.-pos.', 'adj.-inter.-rel.', 'adj.-dem.', 'adj.-nehot.', 'art.-adj.', 'art.-hot.', 'art.-nehot.',
            'art.-pos.', 'num.-card.', 'num.-col.', 'num.-multipl.', 'num.-nehot.', 'num.-ord.', 'vb.-absol.',
            'vb.-fact.', 'vb.-intranz.', 'vb.-refl.', 'vb.-refl. impers.', 'vb.-refl. pas.', 'vb.-refl. recipr.', 'vb.-refl. unipers.',
            'vb.-tranz.', 'vb.-tranz. fact.', 'vb.-intranz. şi refl.'))
        then ()
        else (),            
        if (@value = ('', 'num.-adv.', 'pron.-neg.', 'hot.'))
        then (delete nodes parent::*/element()[position() > 2])
        else (),    
        if (@value = ('pron.-dem.', 'pron.-inter.-rel.', 'pron.-nehot.'))
        then
            (
                delete nodes parent::*/element()[position() > 2]
                ,
                insert nodes (doc('content-models/gen.xml'), doc('content-models/number.xml')) as last into parent::*
            )
        else (),
        if (@value = 'pron.-întăr.')
        then
            (
                delete nodes parent::*/element()[position() > 2]
                ,
                insert nodes (doc('content-models/gen.xml'), doc('content-models/per.xml')) as last into parent::*
            )
        else (),
        if (@value = ('pron.-pers.', 'pron.-pos.', 'pron.-de politeţe'))
        then
            (
                delete nodes parent::*/element()[position() > 2]
                ,
                insert nodes (doc('content-models/per.xml'), doc('content-models/gen.xml'), doc('content-models/number.xml')) as last into parent::*
            )
        else (),
        if (@value = 'pron.-refl.')
        then
            (
                delete nodes parent::*/element()[position() > 2]
                ,
                insert nodes (doc('content-models/per.xml'), doc('content-models/number.xml')) as last into parent::*
            )
        else ()
    )
),
ua:action(
    "changedTypeAttrForIdnoElement",
    map { 
        "name" := "changedTypeAttrForIdnoElement"
    }, 
    (
        if (@n = 'tip-unitate-semantică-subsumată' and @type = '')
        then (
            delete nodes ./following-sibling::form[@type = 'unitate-semantică-subsumată'],
            replace value of node @type with 'unknown'
        )
        else (),
        if (@n = 'tip-unitate-semantică-subsumată' and @type != 'unknown')
        then
            (
                delete nodes ./following-sibling::form[@type = 'unitate-semantică-subsumată']
                ,
                insert node <form xmlns="http://www.tei-c.org/ns/1.0" type="unitate-semantică-subsumată" /> after parent::*/idno[last()]
            )        
        else (),   
        if (parent::*[@type = 'grammatical-information'] and @type = 'unknown')
        then (
            delete nodes ./following-sibling::*
        )
        else (),     
        if (@type = 'cuvântul.titlu-element.moştenit-etimon.atestat')
        then
            (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert node $term-template after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',
                replace value of node ./following-sibling::*[2]/@xml:lang with 'la',
                replace value of node ./following-sibling::*[2]/@type with ''
            )
        else (),
        if (@type = 'cuvântul.titlu-element.moştenit-etimon.neatestat')
        then
            (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert node $term-template after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'low',
                replace value of node ./following-sibling::*[2]/@xml:lang with 'la',
                replace value of node ./following-sibling::*[2]/@type with '' 
            )
        else (),        
        if (@type = 'cuvântul.titlu-element.de.substrat')
        then
            (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, doc('content-models/mentioned.xml')) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'
            )
        else (),  
        if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.prefix')
        then
            (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'prefix',
                replace value of node ./following-sibling::*[3]/@type with 'base'
            )
        else (),        
        if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.sufix')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'base',
                replace value of node ./following-sibling::*[3]/@type with 'sufix'
        )
        else (),        
        if (@type = 'cuvântul.titlu-formație.internă-derivat-cu.prefix.şi.sufix')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'prefix',
                replace value of node ./following-sibling::*[3]/@type with 'base',
                replace value of node ./following-sibling::*[4]/@type with 'sufix'
        )
        else (),        
        if (@type = 'cuvântul.titlu-formație.internă-compus-element.de.compunere.+.cuvânt.bază')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'component-element',
                replace value of node ./following-sibling::*[3]/@type with 'base'
        )
        else (),        
        if (@type = 'cuvântul.titlu-formație.internă-compus-cuvânt.bază.+.element.de.compunere')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'base',
                replace value of node ./following-sibling::*[3]/@type with 'component-element'
        )
        else (),              
        if (@type = 'cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'base',
                replace value of node ./following-sibling::*[3]/@type with 'base'
        )
        else (),
        if (@type = 'cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'latin-base',
                replace value of node ./following-sibling::*[3]/@type with 'added-base'
        )
        else (),
        if (@type = 'cuvântul.titlu-formație.internă-compus-format.din')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'cuvântul.titlu-formație.internă-compus-format.din-bază',
                replace value of node ./following-sibling::*[3]/@type with 'cuvântul.titlu-formație.internă-compus-format.din-element adăugat'
        )
        else (),    
        if (@type = 'cuvântul.titlu-formație.internă-trimitere-V.')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes doc('content-models/ptr.xml') after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'low'
             )
        else (),        
        if (@type = 'cuvântul.titlu-formație.internă-trimitere-Cf.')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes doc('content-models/ptr.xml') after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'
             )
        else (),
        if (@type = 'cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente')
        then (
               delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes ($term-template, $term-template, $term-template, $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high',                
                replace value of node ./following-sibling::*[2]/@type with 'contaminated-element',
                replace value of node ./following-sibling::*[3]/@type with 'alternative-contaminated-element',
                replace value of node ./following-sibling::*[4]/@type with 'contamination-element',
                replace value of node ./following-sibling::*[5]/@type with 'alternative-contamination-element'
        )
        else (),
        if (@type = 'cuvântul.titlu-etimon.neatestat.(reconstruit)')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert node $term-template after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'
        )
        else (),       
        if (@type = 'cuvântul.titlu-element.extern-trimitere')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert node doc('content-models/mentioned.xml') after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'              
             )
        else (),    
        if (@type = 'unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor')
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes (doc('content-models/ptr.xml'), $bibl-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'                
             )
        else (),  
        if (@type =
            (
                'unul.sau.mai.multe.sensuri-sensul-cf..etimon',
                'unul.sau.mai.multe.sensuri-sensul-cf..și.etimon'
            )
        )
        then (
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert nodes (doc('content-models/ptr.xml'), $term-template) after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'                
             )
        else (),        
        
        
        if (@type = 
            (
                'cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.primul.element.este',
                'cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.unul.dintre.elemente.este'        
            )
        )
        then (
               delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
               insert node $term-template after ./following-sibling::*[1],
               replace value of node ./following-sibling::*[1]/@cert with 'high',               
               replace value of node ./following-sibling::*[2]/@type with 'contamination-element'
        )
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
                delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
                insert node $term-template after ./following-sibling::*[1],
                replace value of node ./following-sibling::*[1]/@cert with 'high'
        )
        else (),         
        if (starts-with(@type, 'una.sau.mai.multe.variante.lexicale-') and ends-with(@type, '-trimitere-cf..cuvânt'))
        then (
            delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
            insert node doc('content-models/ptr.xml') after ./following-sibling::*[1],
            replace value of node ./following-sibling::*[1]/@cert with 'high'
        )
        else (), 
        if (starts-with(@type, 'una.sau.mai.multe.variante.lexicale-') and ends-with(@type, '-trimitere-cf..izvor'))
        then (
            delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
            insert node $bibl-template after ./following-sibling::*[1],
            replace value of node ./following-sibling::*[1]/@cert with 'high'
        )
        else (),                 
        if (@type = 
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
        then (
            delete nodes ./following-sibling::*[position() > 1 and not(local-name() = 'note')],
            replace value of node ./following-sibling::*[1]/@cert with 'high'
        )
        else (), 
        if (@type = 'grammatical-information-type-for-adj-et-al')
        then (
            delete nodes ./following-sibling::*,
            insert node doc('content-models/idno.xml') after .
        )
        else (),
        if (@type = 'grammatical-information-type-for-vb')
        then (
            delete nodes ./following-sibling::*,
            insert node doc('content-models/grammatical-information-for-verb.xml') after .
        )
        else (),
        if (@type = 'grammatical-information-subtype-for-pl')
        then (
            delete nodes ./following-sibling::*,
            insert node doc('content-models/grammatical-information-for-plural.xml') after .
        )
        else (),        
        if (@type = 'grammatical-information-subtype-for-case')
        then (
            delete nodes ./following-sibling::*,
            insert node doc('content-models/grammatical-information-for-case.xml') after .
        )
        else (),
        if (@type = 'grammatical-information-subtype-for-gender')
        then (
                delete nodes ./following-sibling::*,
                insert node doc('content-models/grammatical-information-for-gender.xml') after .
        )
        else ()
    )
),
ua:action(
    "insertSenseElementAsFirstChild",
    map { 
        "name" := "insertSenseElementAsFirstChild"
    }, 
    (
        insert node $sense-template as first into .
        ,
        replace value of node *[1]/@xml:id with oxy:uuid()
    )
),
ua:action(
    "insertSenseElementAsFollowingSibling",
    map { 
        "name" := "insertSenseElementAsFollowingSibling"
    }, 
    (
        insert node $sense-template after .
        ,
        replace value of node ./following-sibling::*[1]/@xml:id with oxy:uuid()
    )
),
ua:action(
    "insertCfElements",
    map { 
        "name" := "Cf."
    }, 
    insert node doc('content-models/mentioned.xml') after term
),
ua:action(
    "insertBaseWord",
    map { 
        "name" := "insertBaseWord",
        "smallIconPath" := "../../resources/images/add.png"
    }, 
    (
        insert node $term-template after .
        ,
        replace value of node ./following-sibling::*[1]/@type with 'base'
    )
),
ua:action(
    "insertAlternativeEtymon",
    map { 
        "name" := "Etimon alternativ",
        "smallIconPath" := "../../resources/images/add.png"
    },
    (
        insert nodes ($term-template, $term-template) after .
        ,
        replace value of node ./following-sibling::*[1]/@type with 'contamination-element'
        ,
        replace value of node ./following-sibling::*[2]/@type with 'alternative-contamination-element'
    )
),
ua:action(
    "insertAddedBase",
    map { 
        "name" := "insertAddedBase",
        "smallIconPath" := "../../resources/images/add.png"
    }, 
    (
        insert node $term-template after .
        ,
        replace value of node ./following-sibling::*[1]/@type with 'added-base'
    )
),
ua:action(
    "insertTermElementOfTypeElementAdăugat",
    map { 
        "name" := "insertTermElementOfTypeElementAdăugat",
        "smallIconPath" := "../../resources/images/add.png"
    }, 
    (
        insert node $term-template after .
        ,
        replace value of node ./following-sibling::*[1]/@type with 'cuvântul.titlu-formație.internă-compus-format.din-element adăugat'
    )
),
ua:action(
    "changedValueAttrForUsgElement",
    map { 
        "name" := "changedValueAttrForUsgElement"
    }, 
    (
        replace value of node ./@type with for $a in ./@value return doc('content-models/usg-datalist.xml')//*[@label = $a]/@value/string()
    )
),
ua:action(
    "changedTypeAttrForNoteElement",
    map { 
        "name" := "changedTypeAttrForNoteElement"
    },

    (
        if (@type = ('unknown', 'explicații.etimon-apropiat.de.cuv..rom..terminate.în', 'explicații.etimon-diminutiv.al.lui', 'explicații.etimon-cu.schimbare.de.suf.',
        'explicații.etimon-prin.accidente.fonetice-afereză', 'explicații.etimon-prin.accidente.fonetice-anaptixă', 'explicații.etimon-prin.accidente.fonetice-apocopă',
        'explicații.etimon-prin.accidente.fonetice-elidare', 'explicații.etimon-prin.accidente.fonetice-epenteză', 'explicații.etimon-prin.accidente.fonetice-metateză',
        'explicații.etimon-prin.accidente.fonetice-propagare', 'explicații.etimon-prin.accidente.fonetice-proteză', 'explicații.etimon-prin.accidente.fonetice-sincopă',
        'explicații.etimon-prin.accidente.fonetice-sinereză', 'explicații.etimon-prin.apropiere.de', 'explicații.etimon-prin.analogie.cu', 'explicații.etimon-după.modelul',
        'explicații.etimon-prin.analogie.cu.cuvinte.de.origine', 'explicații.etimon-prin.analogie.cu.cuvinte.de.tipul', 'explicații.etimon-prin.contaminare.cu',
        'explicații.etimon-după.modelul.lui', 'explicații.etimon-variantă.a.lui', 'explicații.etimon-prin.falsă.analiză', 'explicații.etimon-refăcut.după',
        'explicații.etimon-adaptat.după', 'explicații.etimon-din.latina.clasică.pentru.et..*', 'explicații.etimon-cuvânt.din.care.provine.etimonul-.atestat.pentru.et..*',
        'explicații.etimon-după', 'explicații.etimon-prin.filieră', 'explicații.etimon-cu.reduplicarea.consoanei', 'explicații.etimon-imper..lui', 'explicații.etimon-aor..lui',
        'explicații.etimon-voc..lui', 'explicații.etimon-pl..lui', 'explicații.etimon-acuz.', 'explicații.etimon-la.scriitorii.mai.vechi.din', 'explicații.etimon-sub.influența.lui',
        'explicații.etimon-dial.', 'explicații.etimon-prin.reduplicare', 'explicații.etimon-part..lui', 'explicații.etimon-prin.apropiere.de.cuv..formate.cu.suf.',
        'explicații.etimon-prin.analogie.cu', 'explicații.etimon-prin.analogie.cu.cuvinte.de.origine', 'explicații.etimon-prin.analogie.cu.cuvinte.de.tipul',
        'explicații.etimon-prin.etimologie.populară', 'explicații.etimon-s..pr.', 'explicații.etimon-numele.științific.al', 'explicații.etimon-la', 'explicații.etimon-mai.vechi',
        'explicații.etimon-var..a.lui', 'explicații.etimon-de.la.s..pr.', 'explicații.etimon-în.rom.', 'explicații.etimon-sg..refăcut.după.pl.', 'explicații.etimon-numele.topic',
        'explicații.etimon-contaminare.în.care.primul.element.este', 'explicații.etimon-f..lui', 'explicații.etimon-numele.ştiințific.al.plantei', 'explicații.etimon-n..pr.',
        'explicații.etimon-numele.de.localitate', 'explicații.etimon-numele.sărbătorii.religioase', 'explicații.etimon-numele.ştiințific.al.planetei', 'explicații.etimon-prez..ind.',
        'explicații.etimon-prin.analogie.cu.cuvinte.de.origine.….de.tipul.…', 'explicații.etimon-prin.confuzie.cu', 'model.etimon', 'note.suplimentare'))
        then (
        	delete nodes child::*,
        	insert node $term-template as first into .
        )
        else ()
        ,    
        if (@type = ('traducere.etimon', 'traducere.cuvânt.bază', 'explicații.etimon-contaminare.între.….și.…', 'explicații.etimon-prin.înlocuirea.lui.….cu.…',
        'nume.propriu'))
        then (
            delete nodes child::*,
            insert node $term-template as first into .,
            insert node $term-template after ./child::term[1]
        )
        else ()
        ,    
        if (@type = 'trimitere.(cf.)')
        then (
            delete nodes child::*,
            insert node doc('content-models/usg.xml') as first into .,
            insert node $term-template after ./child::usg,
            insert node $term-template after ./child::term
        )
        else () 
        ,    
        if (@type = ('explicații.etimon-pentru.explicarea.formei.româneşti', 'explicații.etimon-pentru.explicarea.formei.românești.cf.'))
        then (
            delete nodes child::*,
            insert node $term-template as first into .,
            insert node $bibl-template after ./child::term[1]
        )
        else ()
        ,    
        if (@type = 'indicații.gramaticale')
        then (
            delete nodes child::*,
            insert node doc('content-models/grammatical-information.xml') as first into .,
            insert node $term-template after ./child::form
        )
        else ()
        ,    
        if (@type = 'izvor')
        then (
            delete nodes child::*,
            insert node $bibl-template as first into .,
            insert node $term-template after ./child::bibl
        )
        else () 
        ,    
        if (@type = 'indicație.folosire')
        then (
            delete nodes child::*,
            insert node doc('content-models/usg.xml') as first into .,
            insert node $term-template after ./child::usg
        )
        else () 
        ,    
        if (@type = 'trimitere.intrare')
        then (
            delete nodes child::*,
            insert node $term-template as first into .,
            insert node doc('content-models/ptr.xml') after ./child::term
        )
        else ()                  
    )
),
ua:action(
    "deleteContaminationElement",
    map { 
        "name" := "Ștergere",
        "smallIconPath" := "../../resources/images/delete.png"        
    },   
    delete nodes (. | preceding-sibling::term[1])
),
ua:action(
    "addEtymonTranslation",
    map { 
        "name" := "Traducere etimon"
    },   
    (
    	insert node $term-template as last into .,
    	replace value of node term[last()]/@type with 'translation'
    )
),
ua:action(
    "addFirstEtymologicalNote",
    map { 
        "name" := "Notă"        
    },   
    (
    	insert node doc('content-models/note.xml') as last into .
    )
),
ua:action(
    "addEtymologicalNote",
    map { 
        "name" := "Adaugă notă",
        "smallIconPath" := "../../resources/images/add.png"
    },   
    (
    	insert node doc('content-models/note.xml') after .
    )
),
ua:action(
    "editEtymologicalNote",
    map { 
        "name" := "Editează notă",
        "smallIconPath" := "${framework}/resources/images/edit.png"
    },   
    oxy:execute-action-by-class('ro.kuberam.oxygen.addonBuilder.operations.OpenFileInNewTabOperation')
),
ua:observer("changedTypeAttrForIdnoElementObserver", "changedTypeAttrForIdnoElement"),
ua:connect-observer("changedTypeAttrForIdnoElementObserver", ua-dt:xpath-selector('//idno'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['type']"}
),

ua:observer("changedValueAttrForSubcElementObserver", "changedValueAttrForSubcElement"),
ua:connect-observer("changedValueAttrForSubcElementObserver", ua-dt:xpath-selector('//subc'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['value']"}
),

ua:observer("changedValueAttrForPosElementObserver", "changedValueAttrForPosElement"),
ua:connect-observer("changedValueAttrForPosElementObserver", ua-dt:xpath-selector('//pos'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['value']"}
),

ua:observer("changedValueAttrForFormElementObserver", "changedValueAttrForFormElement"),
ua:connect-observer("changedValueAttrForFormElementObserver", ua-dt:xpath-selector('//form'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['type']"}
),

ua:observer("changedValueAttrForUsgElementObserver", "changedValueAttrForUsgElement"),
ua:connect-observer("changedValueAttrForUsgElementObserver", ua-dt:xpath-selector('//usg'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['value']"}
),

ua:observer("changedTypeAttrForNoteElementObserver", "changedTypeAttrForNoteElement"),
ua:connect-observer("changedTypeAttrForNoteElementObserver", ua-dt:xpath-selector('//note'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['type']"}
),

ua:add-event-listener($ua:document, "load", oxy:execute-action-by-class('ro.kuberam.oxygen.addonBuilder.actions.KeepAuthorView')),

ua:template("TEI-before-template",
    <template>
        <button onclick="{oxy:xquery-update-action('addFirstAccentuationSection')}" style="visibility: {count(//entry/form[contains(' unknown-accentuation accentuation-variant ', @type)]) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstArticulationSection')}" style="visibility: {count(//entry/form[@type = 'articulation']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstPronunciationSection')}" style="visibility: {count(//entry/form[@type = 'pronunciation']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstWritingSection')}" style="visibility: {count(//entry/form[@type = 'writing']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstAbbreviationSection')}" style="visibility: {count(//entry/form[@type = 'abbreviation']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstGrammaticalInformationSection')}" style="visibility: {count(//entry/form[@type = 'grammatical-information']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstLexicalVariant')}" style="visibility: {count(//entry/form[@type = 'lexical-variant-section']) = 0}; background-color: transparent; color: blue;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("TEI:before"), "TEI-before-template"),

ua:template("grammatical-information-form",
    <template>
        Indicații gramaticale
        <button onclick="{oxy:xquery-update-action('addGrammaticalInformationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        \00000A
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information']:before"), "grammatical-information-form"),

ua:template("trimitere-before",
    <template>
        Trimitere&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'trimitere']:before"), "trimitere-before"),

ua:template("syn-before",
    <template>
        Sinonim&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />      
        <button onclick="{oxy:xquery-update-action('insertSynonym')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />                
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'syn']:before"), "syn-before"),

ua:template("analog-before",
    <template>
        Analogie&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />    
        <button onclick="{oxy:xquery-update-action('insertAnalogy')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'analog']:before"), "analog-before"),

ua:template("asoc-before",
    <template>
        Asociație&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />     
        <button onclick="{oxy:xquery-update-action('insertAssociation')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'asoc']:before"), "asoc-before"),

ua:template("antonim-before",
    <template>
        În  opoziţie cu&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />       
        <button onclick="{oxy:xquery-update-action('insertAntonym')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'antonim']:before"), "antonim-before"),

ua:template("etym-before",
    <template>
        <button onclick="{oxy:xquery-update-action('addEtymElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertCfElements')}" style="visibility: {idno[1]/@type = 'cuvântul.titlu-element.de.substrat'};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" data-showIcon="false" style="visibility: {idno[1]/@type = 'cuvântul.titlu-element.de.substrat'};" />
        <button onclick="{oxy:xquery-update-action('addGrammaticalInformationSection')}" data-showIcon="false" style="visibility: {idno[starts-with(@type, 'cuvântul.titlu-formație.internă-trimitere-')] and count(form[@type = 'grammatical-information']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addEtymonTranslation')}" style="visibility: {idno[1][starts-with(@type, 'una.sau.mai.multe.variante.lexicale-')] and count(term[@type = 'translation']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstEtymologicalNote')}" style="visibility: {count(note) = 0};" />        
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(//entry/etym) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym:before"), "etym-before"),

ua:template("etym-idno-first-of-type",
    <template>
        \00000A Etimologie pentru&amp;nbsp;
        <datalist id="etym-options">
            <option label="" value="unknown" />
            <option label="cuvântul.titlu-element.moştenit-etimon.atestat" value="id1" />
            <option label="cuvântul.titlu-element.moştenit-etimon.neatestat" value="id17" />
            <option label="cuvântul.titlu-element.de.substrat" value="cuvântul.titlu-element.de.substrat" />
            <option label="cuvântul.titlu-formație.internă-derivat-cu.prefix" value="cuvântul.titlu-formație.internă-derivat-cu.prefix" />
            <option label="cuvântul.titlu-formație.internă-derivat-cu.sufix" value="cuvântul.titlu-formație.internă-derivat-cu.sufix" />
            <option label="cuvântul.titlu-formație.internă-derivat-cu.prefix.şi.sufix" value="cuvântul.titlu-formație.internă-derivat-cu.prefix.şi.sufix" />
            <option label="cuvântul.titlu-formație.internă-compus-element.de.compunere.+.cuvânt.bază" value="cuvântul.titlu-formație.internă-compus-element.de.compunere.+.cuvânt.bază" />
            <option label="cuvântul.titlu-formație.internă-compus-cuvânt.bază.+.element.de.compunere" value="cuvântul.titlu-formație.internă-compus-cuvânt.bază.+.element.de.compunere" />
            <option label="cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază" value="cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază" />
            <option label="cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină" value="cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină" />
            <option label="cuvântul.titlu-formație.internă-compus-format.din" value="cuvântul.titlu-formație.internă-compus-format.din" />
            <option label="cuvântul.titlu-formație.internă-derivat.regresiv" value="cuvântul.titlu-formație.internă-derivat.regresiv" />
            <option label="cuvântul.titlu-formație.internă-derivat.postverbal" value="cuvântul.titlu-formație.internă-derivat.postverbal" />
            <option label="cuvântul.titlu-formație.internă-trimitere-V." value="cuvântul.titlu-formație.internă-trimitere-V." />
            <option label="cuvântul.titlu-formație.internă-trimitere-Cf." value="cuvântul.titlu-formație.internă-trimitere-Cf." />
            <option label="cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.plantei" value="cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.plantei" />
            <option label="cuvântul.titlu-formație.internă-trimitere-De.la-n..pr." value="cuvântul.titlu-formație.internă-trimitere-De.la-n..pr." />
            <option label="cuvântul.titlu-formație.internă-trimitere-De.la-numele.de.localitate" value="cuvântul.titlu-formație.internă-trimitere-De.la-numele.de.localitate" />
            <option label="cuvântul.titlu-formație.internă-trimitere-De.la-numele.sărbătorii.religioase" value="cuvântul.titlu-formație.internă-trimitere-De.la-numele.sărbătorii.religioase" />
            <option label="cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.planetei" value="cuvântul.titlu-formație.internă-trimitere-De.la-numele.ştiințific.al.planetei" />
            <option label="cuvântul.titlu-formație.internă-trimitere-Din-etimon.atestat" value="cuvântul.titlu-formație.internă-trimitere-Din-etimon.atestat" />
            <option label="cuvântul.titlu-formație.internă-trimitere-Din-etimon.*" value="cuvântul.titlu-formație.internă-trimitere-Din-etimon.*" />
            <option label="cuvântul.titlu-formație.internă-prescurtare" value="cuvântul.titlu-formație.internă-prescurtare" />
            <option label="cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.primul.element.este" value="cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.primul.element.este" />
            <option label="cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.unul.dintre.elemente.este" value="cuvântul.titlu-formație.internă-contaminare-cu.un.element-în.care.unul.dintre.elemente.este" />
            <option label="cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente" value="cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente" />
            <option label="cuvântul.titlu-formație.internă-calc" value="cuvântul.titlu-formație.internă-calc" />
            <option label="cuvântul.titlu-formație.internă-onomatopee" value="cuvântul.titlu-formație.internă-onomatopee" />
            <option label="cuvântul.titlu-formație.internă-contragere" value="cuvântul.titlu-formație.internă-contragere" />
            <option label="cuvântul.titlu-formație.internă-izolare-prin.analiză.din.împrumuturi.ca" value="cuvântul.titlu-formație.internă-izolare-prin.analiză.din.împrumuturi.ca" />
            <option label="cuvântul.titlu-formație.internă-izolare-prin.analiză.din.cuvinte.compuse.împrumutate" value="cuvântul.titlu-formație.internă-izolare-prin.analiză.din.cuvinte.compuse.împrumutate" />
            <option label="cuvântul.titlu-formație.internă-izolare-din.nume.de.localităţi" value="cuvântul.titlu-formație.internă-izolare-din.nume.de.localităţi" />
            <option label="cuvântul.titlu-formație.internă-singular.refăcut.după.plural" value="cuvântul.titlu-formație.internă-singular.refăcut.după.plural" />
            <option label="cuvântul.titlu-formație.internă-formație.onomatopeică" value="cuvântul.titlu-formație.internă-formație.onomatopeică" />
            <option label="cuvântul.titlu-formație.internă-formație.spontană.de.la" value="cuvântul.titlu-formație.internă-formație.spontană.de.la" />
            <option label="cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la" value="cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la" />
            <option label="cuvântul.titlu-formație.internă-din.formulă.de.urare" value="cuvântul.titlu-formație.internă-din.formulă.de.urare" />
            <option label="cuvântul.titlu-formație.internă-format.după" value="cuvântul.titlu-formație.internă-format.după" />
            <option label="cuvântul.titlu-formație.internă-denumire.comercială" value="cuvântul.titlu-formație.internă-denumire.comercială" />
            <option label="cuvântul.titlu-element.extern-împrumut-etimon.sigur" value="cuvântul.titlu-element.extern-împrumut-etimon.sigur" />
            <option label="cuvântul.titlu-etimon.neatestat.(reconstruit)" value="cuvântul.titlu-etimon.neatestat.(reconstruit)" />
            <option label="cuvântul.titlu-element.extern-calc" value="cuvântul.titlu-element.extern-calc" />
            <option label="cuvântul.titlu-element.extern-trimitere" value="cuvântul.titlu-element.extern-trimitere" />
            <option label="cuvântul.titlu-element.necunoscut" value="cuvântul.titlu-element.necunoscut" />
            <option label="unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor" value="unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor" />
            <option label="unul.sau.mai.multe.sensuri-sensul-cf..etimon" value="unul.sau.mai.multe.sensuri-sensul-cf..etimon" />
            <option label="unul.sau.mai.multe.sensuri-sensul-cf..și.etimon" value="unul.sau.mai.multe.sensuri-sensul-cf..și.etimon" />
            <option label="variantă-directă-etimon.variantă-atestat" value="variantă-directă-etimon.variantă-atestat" />
            <option label="variantă-directă-etimon.variantă-reconstruit" value="variantă-directă-etimon.variantă-reconstruit" />
            <option label="variantă-directă-sg..refăcut.după.plural" value="variantă-directă-sg..refăcut.după.plural" />            
            <option label="variantă-directă-singular.refăcut.după.pluralul" value="variantă-directă-singular.refăcut.după.pluralul" />
            <option label="variantă-directă-prin.apropiere.de" value="variantă-directă-prin.apropiere.de" />
            <option label="variantă-directă-prin.etimologie.populară" value="variantă-directă-prin.etimologie.populară" />
            <option label="variantă-directă-prin.accidente.fonetice-afereză" value="variantă-directă-prin.accidente.fonetice-afereză" />
            <option label="variantă-directă-prin.accidente.fonetice-proteză" value="variantă-directă-prin.accidente.fonetice-proteză" />
            <option label="variantă-directă-prin.accidente.fonetice-sincopă" value="variantă-directă-prin.accidente.fonetice-sincopă" />
            <option label="variantă-directă-prin.accidente.fonetice-epenteză" value="variantă-directă-prin.accidente.fonetice-epenteză" />
            <option label="variantă-directă-prin.accidente.fonetice-anaptixă" value="variantă-directă-prin.accidente.fonetice-anaptixă" />
            <option label="variantă-directă-prin.accidente.fonetice-apocopă" value="variantă-directă-prin.accidente.fonetice-apocopă" />
            <option label="variantă-directă-prin.accidente.fonetice-elidare" value="variantă-directă-prin.accidente.fonetice-elidare" />
            <option label="variantă-directă-prin.accidente.fonetice-metateză" value="variantă-directă-prin.accidente.fonetice-metateză" />
            <option label="variantă-directă-prin.accidente.fonetice-propagare" value="variantă-directă-prin.accidente.fonetice-propagare" />
            <option label="variantă-directă-prin.accidente.fonetice-sinereză" value="variantă-directă-prin.accidente.fonetice-sinereză" />
            <option label="variantă-directă-cu.schimbare.de.suf." value="variantă-directă-cu.schimbare.de.suf." />
            <option label="variantă-directă-prin.derivare.cu.suf." value="variantă-directă-prin.derivare.cu.suf." />
            <option label="variantă-directă-sub.influența" value="variantă-directă-sub.influența" />
            <option label="variantă-directă-refăcut.după.forma.articulată" value="variantă-directă-refăcut.după.forma.articulată" />
            <option label="variantă-directă-refăcut.după.sg..art." value="variantă-directă-refăcut.după.sg..art." />
            <option label="variantă-directă-etimologie.populară.prin.apropiere.de" value="variantă-directă-etimologie.populară.prin.apropiere.de" />
            <option label="variantă-directă-din.lat." value="variantă-directă-din.lat." />
            <option label="variantă-directă-derivat.regresiv.de.la" value="variantă-directă-derivat.regresiv.de.la" />
            <option label="variantă-directă-prin.confuzie.cu" value="variantă-directă-prin.confuzie.cu" />
            <option label="una.sau.mai.multe.variante.lexicale-variantă-trimitere-cf..cuvânt" value="una.sau.mai.multe.variante.lexicale-variantă-trimitere-cf..cuvânt" />
            <option label="una.sau.mai.multe.variante.lexicale-variantă-trimitere-cf..izvor" value="una.sau.mai.multe.variante.lexicale-variantă-trimitere-cf..izvor" />
            <option label="una.sau.mai.multe.variante.lexicale-variante.cu-trimitere-cf..cuvânt" value="una.sau.mai.multe.variante.lexicale-variante.cu-trimitere-cf..cuvânt" />
            <option label="una.sau.mai.multe.variante.lexicale-variante.cu-trimitere-cf..izvor" value="una.sau.mai.multe.variante.lexicale-variante.cu-trimitere-cf..izvor" />
            <option label="una.sau.mai.multe.variante.lexicale-variante.de.tipul-trimitere-cf..cuvânt" value="una.sau.mai.multe.variante.lexicale-variante.de.tipul-trimitere-cf..cuvânt" />
            <option label="una.sau.mai.multe.variante.lexicale-variante.de.tipul-trimitere-cf..izvor" value="una.sau.mai.multe.variante.lexicale-variante.de.tipul-trimitere-cf..izvor" />
        </datalist>
        <input data-ua-ref="{@type}" size="80" list="etym-options" />               
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno:first-of-type"), "etym-idno-first-of-type"),

ua:template("variantă-directă-etimon variantă-*-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'variantă-directă-etimon variantă-'] ~ term"), "variantă-directă-etimon variantă-*-template"),

ua:template("cuvântul.titlu-formație.internă-singular.refăcut.după.plural-template",
    <template>
        Singular refăcut după plural&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-singular.refăcut.după.plural'] ~ term"), "cuvântul.titlu-formație.internă-singular.refăcut.după.plural-template"),

ua:template("cuvântul.titlu-formație.internă-formație.onomatopeică-template",
    <template>
        Formaţie onomatopeică&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-formație.onomatopeică'] ~ term"), "cuvântul.titlu-formație.internă-formație.onomatopeică-template"),

ua:template("cuvântul.titlu-formație.internă-formație.spontană.de.la-template",
    <template>
        Formaţie spontană de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-formație.spontană.de.la'] ~ term"), "cuvântul.titlu-formație.internă-formație.spontană.de.la-template"),

ua:template("cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la-template",
    <template>
        Prin figură etimologică de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la'] ~ term"), "cuvântul.titlu-formație.internă-prin.figură.etimologică.de.la-template"),

ua:template("cuvântul.titlu-formație.internă-contragere-template",
    <template>
        Contras din&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-contragere'] ~ term"), "cuvântul.titlu-formație.internă-contragere-template"),

ua:template("cuvântul.titlu-formație.internă-din.formulă.de.urare-template",
    <template>
        Din formulă de urare&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-din.formulă.de.urare'] ~ term"), "cuvântul.titlu-formație.internă-din.formulă.de.urare-template"),

ua:template("cuvântul.titlu-formație.internă-format.după-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-format.după'] ~ term"), "cuvântul.titlu-formație.internă-format.după-template"),

ua:template("cuvântul.titlu-formație.internă-denumire.comercială-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-denumire.comercială'] ~ term"), "cuvântul.titlu-formație.internă-denumire.comercială-template"),

ua:template("cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină-term-first-of-type-template",
    <template>
        lat.
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină'] ~ term:first-of-type:after"), "cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină-term-first-of-type-template"),

ua:template("cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină-term-not-first-of-type-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:execute-action-by-name('insertAddedBase')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/term) >= 3};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină'] ~ term:not( :first-of-type):after"), "cuvântul.titlu-formație.internă-compus-formație.savantă.din.latină-term-not-first-of-type-template"),

ua:template("cuvântul.titlu-formație.internă-compus-format.din-term-bază-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-compus-format.din'] ~ term[type = 'cuvântul.titlu-formație.internă-compus-format.din-bază']:after"), "cuvântul.titlu-formație.internă-compus-format.din-term-bază-template"),

ua:template("cuvântul.titlu-formație.internă-compus-format.din-term-element adăugat-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:execute-action-by-name('insertTermElementOfTypeElementAdăugat')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'cuvântul.titlu-formație.internă-compus-format.din-element adăugat']) >= 2};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-compus-format.din'] ~ term[type = 'cuvântul.titlu-formație.internă-compus-format.din-element adăugat']:after"), "cuvântul.titlu-formație.internă-compus-format.din-term-element adăugat-template"),

ua:template("translation", <template>Traducere etimon <input data-ua-ref="{text()}" size="22" /><button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'translation']"), "translation"),

ua:template("variantă-directă-singular.refăcut.după.pluralul-template",
    <template>
        Sg. refăcut după pluralul&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-singular.refăcut.după.pluralul'] ~ term"), "variantă-directă-singular.refăcut.după.pluralul-template")
,
ua:template("variantă-directă-prin.apropiere.de-template",
    <template>
        Prin apropiere de&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-prin.apropiere.de'] ~ term"), "variantă-directă-prin.apropiere.de-template")
,
ua:template("variantă-directă-prin.derivare.cu.suf.-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }    
        Prin derivare cu sufix&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-prin.derivare.cu.suf.'] ~ term"), "variantă-directă-prin.derivare.cu.suf.-template")
,
ua:template("variantă-directă-sub.influența-template",
    <template>
        Sub influenţa&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-sub.influența'] ~ term"), "variantă-directă-sub.influența-template")
,
ua:template("variantă-directă-etimologie.populară.prin.apropiere.de-template",
    <template>
        Etimologie populară prin apropiere de&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-etimologie.populară.prin.apropiere.de'] ~ term"), "variantă-directă-etimologie.populară.prin.apropiere.de-template")
,
ua:template("variantă-directă-din.lat.-template",
    <template>
        Din lat.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-din.lat.'] ~ term"), "variantă-directă-din.lat.-template")
,
ua:template("variantă-directă-prin.confuzie.cu-template",
    <template>
        Prin confuzie cu&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-prin.confuzie.cu'] ~ term"), "variantă-directă-prin.confuzie.cu-template")
,
ua:template("una.sau.mai.multe.variante.lexicale-*-trimitere-cf..cuvânt-template",
    <template>
        Cf.&amp;nbsp;
        <input data-ua-ref="{text()}" size="5" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'una.sau.mai.multe.variante.lexicale-'][type $= '-trimitere-cf..cuvânt'] ~ ptr"), "una.sau.mai.multe.variante.lexicale-*-trimitere-cf..cuvânt-template")
,
ua:template("cuvântul.titlu-formație.internă-izolare-term",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul.titlu-formație.internă-izolare-'] ~ term"), "cuvântul.titlu-formație.internă-izolare-term"),
        
ua:template("cuvântul.titlu-formație.internă-trimitere-V.-template",
    <template>
        V.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-trimitere-V.'] ~ ptr"), "cuvântul.titlu-formație.internă-trimitere-V.-template"),

ua:template("cuvântul.titlu-formație.internă-trimitere-Cf.-template",
    <template>
        Cf.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-trimitere-Cf.'] ~ ptr"), "cuvântul.titlu-formație.internă-trimitere-Cf.-template"),

ua:template("cuvântul.titlu-formație.internă-trimitere-De la-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul.titlu-formație.internă-trimitere-De la-'] ~ term"), "cuvântul.titlu-formație.internă-trimitere-De la-template"),

ua:template("cuvântul.titlu-etimon.neatestat.(reconstruit)-term",
    <template>
        etimon neatestat&amp;nbsp;
        <select data-ua-ref="{@xml:lang}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="lat*" value="la" />
            <option label="v. sl." value="v. sl." />            
        </select>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-etimon.neatestat.(reconstruit)'] ~ term"), "cuvântul.titlu-etimon.neatestat.(reconstruit)-term"),

ua:template("cuvântul.titlu-formație.internă-trimitere-Din-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul.titlu-formație.internă-trimitere-Din-'] ~ term"), "cuvântul.titlu-formație.internă-trimitere-Din-template"),

ua:template("cuvântul.titlu-element.extern-calc-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        &amp;nbsp;Calc după&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-element.extern-calc'] ~ term"), "cuvântul.titlu-element.extern-calc-template"),

ua:template("cuvântul.titlu-element.necunoscut-template",
    <template>
        Et. nec.
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-element.necunoscut'] ~ term"), "cuvântul.titlu-element.necunoscut-template"),

ua:template("unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor-template",
    <template>
        Număr de sens&amp;nbsp;
        {
            ua:get-template(oxy:get-template("combo",
                map {
                    "edit" := "@target",
                    "editable" := false,
                    "values" := string-join(//sense/@xml:id, ','),
                    "labels" := string-join(//sense/idno[1]/@n, ',')
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('insertSenseNumber')}" style="background-color: transparent;" />        
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor'] ~ ptr:after"), "unul.sau.mai.multe.sensuri-explicarea.sensului-cf..izvor-template"),

ua:template("unul.sau.mai.multe.sensuri-sensul-*-ptr-template",
    <template>
        Număr de sens&amp;nbsp;
        {
            ua:get-template(oxy:get-template("combo",
                map {
                    "edit" := "@target",
                    "editable" := false,
                    "values" := string-join(//sense/@xml:id, ','),
                    "labels" := string-join(//sense/idno[1]/@n, ',')
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('insertSenseNumber')}" style="background-color: transparent;" />        
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'unul.sau.mai.multe.sensuri-sensul-'] ~ ptr:after"), "unul.sau.mai.multe.sensuri-sensul-*-ptr-template"),

ua:template("unul.sau.mai.multe.sensuri-sensul-cf..etimon-term-template",
    <template>
        Cf.&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'unul.sau.mai.multe.sensuri-sensul-cf..etimon'] ~ term:after"), "unul.sau.mai.multe.sensuri-sensul-cf..etimon-term-template"),

ua:template("unul.sau.mai.multe.sensuri-sensul-cf..și.etimon-template",
    <template>
        Cf. și&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'unul.sau.mai.multe.sensuri-sensul-cf..și.etimon'] ~ term:after"), "unul.sau.mai.multe.sensuri-sensul-cf..și.etimon-template"),

ua:template("etym-mentioned",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > mentioned"), "etym-mentioned"),

ua:template("cuvântul.titlu-element.extern-trimitere-mentioned",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        &amp;nbsp;Cf.&amp;nbsp;
        {
            ua:get-template("etym-mentioned")
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-element.extern-trimitere'] ~ mentioned"), "cuvântul.titlu-element.extern-trimitere-mentioned"),

ua:template("etym-certainty-template",
    <template>
        Probabilitate etimologie&amp;nbsp;
        <input data-ua-ref="{@cert}" type="radio" value="high">sigur</input>
        <input data-ua-ref="{@cert}" type="radio" value="low">probabil</input>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > certainty"), "etym-certainty-template"),

ua:template("cuvântul.titlu-element.de.substrat-mentioned-etymon",
    <template>
        Cf.&amp;nbsp;
        <select data-ua-ref="{@xml:lang}" contenteditable="false">
            <option label="" value="" />
            <option label="alb." value="sq" />
            <option label="lituan." value="lt" />
            <option label="v. sl." value="v. sl." />            
        </select>
        {
            ua:get-template("etym-mentioned")
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-element.de.substrat'] ~ mentioned"), "cuvântul.titlu-element.de.substrat-mentioned-etymon"),

ua:template("cuvântul.titlu-element.de.substrat-term-etymon",
    <template>
        El. de substrat&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-element.de.substrat'] ~ term"), "cuvântul.titlu-element.de.substrat-term-etymon"),

ua:template("cuvântul.titlu-element.moştenit-etimon.atestat-etymon",
    <template>
        Lat.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        În funcţie de partea de vorbire se vor indica următoarele forme ale etimonului: pentru s./ subst. - Nom. şi Gen; pentru adj. - formele de m, f şi n.; pentru vb. - inf. lung ; pentru pron. - formele de Nom., Gen. şi Dat.; pentru num. - formele de m. şi f.; pentru art. - formele de m. şi f.
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-element.moştenit-etimon.atestat'] ~ term"), "cuvântul.titlu-element.moştenit-etimon.atestat-etymon"),

ua:template("cuvântul.titlu-element.moştenit-etimon.neatestat-etymon",
    <template>
        Lat. *&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-element.moştenit-etimon.neatestat'] ~ term"), "cuvântul.titlu-element.moştenit-etimon.neatestat-etymon"),

ua:template("etym-term-prefix",
    <template>
        Prefix&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'prefix']"), "etym-term-prefix"),

ua:template("etym-term-base",
    <template>
        &amp;nbsp;Cuvânt de bază&amp;nbsp;
		<input data-ua-ref="{text()}" size="40" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        <button onclick="{oxy:execute-action-by-name('insertBaseWord')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'base']) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'base']"), "etym-term-base"),

ua:template("etym-term-multiple-base",
    <template>
        &amp;nbsp;Cuvânt de bază&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        <button onclick="{oxy:execute-action-by-name('insertBaseWord')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'base']) > 2};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'multiple-base']"), "etym-term-multiple-base"),

ua:template("etym-term-sufix",
    <template>
        Sufix&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'sufix']"), "etym-term-sufix"),

ua:template("etym-term-component-element",
    <template>
        Element de compunere&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'component-element']"), "etym-term-component-element"),

ua:template("cuvântul.titlu-formație.internă-derivat.regresiv-template",
    <template>
        Derivat regresiv de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-derivat.regresiv'] ~ term"), "cuvântul.titlu-formație.internă-derivat.regresiv-template")
,
ua:template("variantă-directă-derivat.regresiv.de.la-template",
    <template>
        Derivat regresiv de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-derivat.regresiv.de.la'] ~ term"), "variantă-directă-derivat.regresiv.de.la-template")
,
ua:template("cuvântul.titlu-formație.internă-derivat.postverbal-template",
    <template>
        Derivat postverbal de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-derivat.postverbal'] ~ term"), "cuvântul.titlu-formație.internă-derivat.postverbal-template"),

ua:template("cuvântul.titlu-formație.internă-prescurtare-template",
    <template>
        Prescurtat de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-prescurtare'] ~ term"), "cuvântul.titlu-formație.internă-prescurtare-template"),

ua:template("cuvântul.titlu-formație.internă-onomatopee-template",
    <template>
        Onomatopee&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-onomatopee'] ~ term"), "cuvântul.titlu-formație.internă-onomatopee-template"),

ua:template("contamination-element",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'contamination-element']"), "contamination-element"),

ua:template("contaminated-element",
    <template>
        Contaminare între&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'contaminated-element']"), "contaminated-element"),

ua:template("alternative-contaminated-element",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'alternative-contaminated-element']"), "alternative-contaminated-element"),

ua:template("contamination-between",
    <template>
        &amp;nbsp;şi&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'contaminated-element'] ~ term[type = 'contamination-element']"), "contamination-between"),

ua:template("alternative-contamination-between",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:execute-action-by-name('insertAlternativeEtymon')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteContaminationElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'alternative-contamination-element']) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'contaminated-element'] ~ term[type = 'alternative-contamination-element']"), "alternative-contamination-between"),

ua:template("cuvântul.titlu-element.extern-împrumut-etimon.sigur-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        tip etimon sigur&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="cuv. chinezesc" value="cuv. chinezesc" />
            <option label="cuv. japonez" value="cuv. japonez" />
            <option label="cuv. mongol" value="cuv. mongol" />
            <option label="împrumut savant din greacă" value="împrumut savant din greacă" />
        </select>        
        &amp;nbsp;etimon sigur&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-element.extern-împrumut-etimon.sigur'] ~ term"), "cuvântul.titlu-element.extern-împrumut-etimon.sigur-template"),

ua:template("cuvântul.titlu-formație.internă-calc-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-calc'] ~ term"), "cuvântul.titlu-formație.internă-calc-template"),

ua:template("etym-note-template",
    <template>
		Notă&amp;nbsp;
		<button onclick="{oxy:execute-action-by-name('addEtymologicalNote')}" style="background-color: transparent;" />
		<button onclick="{oxy:execute-action-by-name('editEtymologicalNote')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > note:before"), "etym-note-template"),

ua:template("etym-edited-note-template",
    <template>
        <select data-ua-ref="{@n}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="cf." value="cf." />
            <option label="cf. și" value="cf. și" />
        </select>
        Probabilitate&amp;nbsp;
        <input data-ua-ref="{@cert}" type="radio" value="high">sigur</input>
        <input data-ua-ref="{@cert}" type="radio" value="low">probabil</input>
    	Tip&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="traducere.etimon" value="traducere.etimon" />
            <option label="traducere.cuvânt.bază" value="traducere.cuvânt.bază" />
            <option label="explicații.etimon-apropiat.de.cuv..rom..terminate.în" value="explicații.etimon-apropiat.de.cuv..rom..terminate.în" />
            <option label="explicații.etimon-diminutiv.al.lui" value="explicații.etimon-diminutiv.al.lui" />
            <option label="explicații.etimon-cu.schimbare.de.suf." value="explicații.etimon-cu.schimbare.de.suf." />
            <option label="explicații.etimon-prin.accidente.fonetice-afereză" value="explicații.etimon-prin.accidente.fonetice-afereză" />
            <option label="explicații.etimon-prin.accidente.fonetice-anaptixă" value="explicații.etimon-prin.accidente.fonetice-anaptixă" />
            <option label="explicații.etimon-prin.accidente.fonetice-apocopă" value="explicații.etimon-prin.accidente.fonetice-apocopă" />
            <option label="explicații.etimon-prin.accidente.fonetice-elidare" value="explicații.etimon-prin.accidente.fonetice-elidare" />            
            <option label="explicații.etimon-prin.accidente.fonetice-epenteză" value="explicații.etimon-prin.accidente.fonetice-epenteză" />
            <option label="explicații.etimon-prin.accidente.fonetice-metateză" value="explicații.etimon-prin.accidente.fonetice-metateză" />
            <option label="explicații.etimon-prin.accidente.fonetice-propagare" value="explicații.etimon-prin.accidente.fonetice-propagare" />
            <option label="explicații.etimon-prin.accidente.fonetice-proteză" value="explicații.etimon-prin.accidente.fonetice-proteză" />
            <option label="explicații.etimon-prin.accidente.fonetice-sincopă" value="explicații.etimon-prin.accidente.fonetice-sincopă" />
            <option label="explicații.etimon-prin.accidente.fonetice-sinereză" value="explicații.etimon-prin.accidente.fonetice-sinereză" />
            <option label="explicații.etimon-prin.apropiere.de" value="explicații.etimon-prin.apropiere.de" />
            <option label="explicații.etimon-prin.analogie.cu" value="explicații.etimon-prin.analogie.cu" />
            <option label="explicații.etimon-prin.analogie.cu.cuvinte.de.origine" value="explicații.etimon-prin.analogie.cu.cuvinte.de.origine" />
            <option label="explicații.etimon-prin.analogie.cu.cuvinte.de.tipul" value="explicații.etimon-prin.analogie.cu.cuvinte.de.tipul" />
            <option label="explicații.etimon-prin.contaminare.cu" value="explicații.etimon-prin.contaminare.cu" />
            <option label="explicații.etimon-după.modelul" value="explicații.etimon-după.modelul" />
            <option label="explicații.etimon-după.modelul.lui" value="explicații.etimon-după.modelul.lui" />
            <option label="explicații.etimon-variantă.a.lui" value="explicații.etimon-variantă.a.lui" />
            <option label="explicații.etimon-prin.falsă.analiză" value="explicații.etimon-prin.falsă.analiză" />
            <option label="explicații.etimon-refăcut.după" value="explicații.etimon-refăcut.după" />
            <option label="explicații.etimon-adaptat.după" value="explicații.etimon-adaptat.după" />
            <option label="explicații.etimon-din.latina.clasică.pentru.et..*" value="explicații.etimon-din.latina.clasică.pentru.et..*" />
            <option label="explicații.etimon-cuvânt.din.care.provine.etimonul-.atestat.pentru.et..*" value="explicații.etimon-cuvânt.din.care.provine.etimonul-.atestat.pentru.et..*" />
            <option label="explicații.etimon-pentru.explicarea.formei.româneşti" value="explicații.etimon-pentru.explicarea.formei.româneşti" />
            <option label="explicații.etimon-după" value="explicații.etimon-după" />
            <option label="explicații.etimon-prin.filieră" value="explicații.etimon-prin.filieră" />
            <option label="explicații.etimon-cu.reduplicarea.consoanei" value="explicații.etimon-cu.reduplicarea.consoanei" />
            <option label="explicații.etimon-imper..lui" value="explicații.etimon-imper..lui" />
            <option label="explicații.etimon-aor..lui" value="explicații.etimon-aor..lui" />
            <option label="explicații.etimon-voc..lui" value="explicații.etimon-voc..lui" />
            <option label="explicații.etimon-pl..lui" value="explicații.etimon-pl..lui" />
            <option label="explicații.etimon-acuz." value="explicații.etimon-acuz." />
            <option label="explicații.etimon-la.scriitorii.mai.vechi.din" value="explicații.etimon-la.scriitorii.mai.vechi.din" />
            <option label="explicații.etimon-sub.influența.lui" value="explicații.etimon-sub.influența.lui" />
            <option label="explicații.etimon-dial." value="explicații.etimon-dial." />
            <option label="explicații.etimon-prin.reduplicare" value="explicații.etimon-prin.reduplicare" />
            <option label="explicații.etimon-part..lui" value="explicații.etimon-part..lui" />
            <option label="explicații.etimon-prin.apropiere.de.cuv..formate.cu.suf." value="explicații.etimon-prin.apropiere.de.cuv..formate.cu.suf." />
            <option label="explicații.etimon-prin.analogie.cu" value="explicații.etimon-prin.analogie.cu" />
            <option label="explicații.etimon-prin.analogie.cu.cuvinte.de.origine" value="explicații.etimon-prin.analogie.cu.cuvinte.de.origine" />
            <option label="explicații.etimon-prin.analogie.cu.cuvinte.de.tipul" value="explicații.etimon-prin.analogie.cu.cuvinte.de.tipul" />
            <option label="explicații.etimon-prin.etimologie.populară" value="explicații.etimon-prin.etimologie.populară" />
            <option label="explicații.etimon-s..pr." value="explicații.etimon-s..pr." />
            <option label="explicații.etimon-numele.științific.al" value="explicații.etimon-numele.științific.al" />
            <option label="explicații.etimon-la" value="explicații.etimon-la" />
            <option label="explicații.etimon-mai.vechi" value="explicații.etimon-mai.vechi" />
            <option label="explicații.etimon-var..a.lui" value="explicații.etimon-var..a.lui" />
            <option label="explicații.etimon-de.la.s..pr." value="explicații.etimon-de.la.s..pr." />
            <option label="explicații.etimon-în.rom." value="explicații.etimon-în.rom." />
            <option label="explicații.etimon-sg..refăcut.după.pl." value="explicații.etimon-sg..refăcut.după.pl." />
            <option label="explicații.etimon-numele.topic" value="explicații.etimon-numele.topic" />
            <option label="explicații.etimon-contaminare.în.care.primul.element.este" value="explicații.etimon-contaminare.în.care.primul.element.este" />
            <option label="explicații.etimon-contaminare.între.….și.…" value="explicații.etimon-contaminare.între.….și.…" />
            <option label="explicații.etimon-f..lui" value="explicații.etimon-f..lui" />
            <option label="explicații.etimon-numele.ştiințific.al.plantei" value="explicații.etimon-numele.ştiințific.al.plantei" />
            <option label="explicații.etimon-n..pr." value="explicații.etimon-n..pr." />
            <option label="explicații.etimon-numele.de.localitate" value="explicații.etimon-numele.de.localitate" />
            <option label="explicații.etimon-numele.sărbătorii.religioase" value="explicații.etimon-numele.sărbătorii.religioase" />
            <option label="explicații.etimon-numele.ştiințific.al.planetei" value="explicații.etimon-numele.ştiințific.al.planetei" />
            <option label="explicații.etimon-pentru.explicarea.formei.românești.cf." value="explicații.etimon-pentru.explicarea.formei.românești.cf." />
            <option label="explicații.etimon-prez..ind." value="explicații.etimon-prez..ind." />
            <option label="explicații.etimon-rin.înlocuirea.lui.….cu.…" value="explicații.etimon-prin.înlocuirea.lui.….cu.…" />
            <option label="explicații.etimon-prin.analogie.cu.cuvinte.de.origine.….de.tipul.…" value="explicații.etimon-prin.analogie.cu.cuvinte.de.origine.….de.tipul.…" />
            <option label="explicații.etimon-prin.confuzie.cu" value="explicații.etimon-prin.confuzie.cu" />
            <option label="trimitere.(cf.)" value="trimitere.(cf.)" />
            <option label="trimitere.intrare" value="trimitere.intrare" />
            <option label="nume.propriu" value="nume.propriu" />
            <option label="indicații.gramaticale" value="indicații.gramaticale" />
            <option label="indicație.folosire" value="indicație.folosire" />
            <option label="model.etimon" value="model.etimon" />
            <option label="izvor" value="izvor" />
            <option label="note.suplimentare" value="note.suplimentare" />            
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("note:root[type]"), "etym-edited-note-template"),

ua:template("etym-note-term1-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note > term:nth-of-type(1):before"), "etym-note-term1-template"),

ua:template("etym-note-traducere.etimon-term-template",
    <template>
    	Traducere etimon&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'traducere.etimon'] > term:nth-of-type(2):before"), "etym-note-traducere.etimon-term-template"),

ua:template("etym-note-traducere.cuvânt.bază-term-template",
    <template>
    	Traducere cuvânt bază&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'traducere.cuvânt.bază'] > term:nth-of-type(2):before"), "etym-note-traducere.cuvânt.bază-term-template"),

ua:template("etym-note-languages-term-template",
    <template>
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'explicații.etimon-după.modelul'] > term:nth-of-type(1):before, note[type = 'explicații.etimon-prin.filieră'] > term:nth-of-type(1):before, 
note[type ~= 'explicații.etimon-la.scriitorii.mai.vechi.din'] > term:nth-of-type(1):before, note[type = 'explicații.etimon-prin.analogie.cu.cuvinte.de.origine.….de.tipul.…'] > term:nth-of-type(1):before,
note[type = 'trimitere.(cf.)'] > term:nth-of-type(1):before"), "etym-note-languages-term-template"),

ua:template("etym-note-term2-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'explicații.etimon-contaminare.între.….și.…'] > term:nth-of-type(2):before,
note[type = 'explicații.etimon-prin.înlocuirea.lui.….cu.…'] > term:nth-of-type(2):before,
note[type = 'trimitere.(cf.)'] > term:nth-of-type(2):before"), "etym-note-term2-template"),

ua:template("etym-note-trimitere.(cf.)-term2-template",
    <template>
        traducere&amp;nbsp;   
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'trimitere.(cf.)'] > term:nth-of-type(2):before"), "etym-note-trimitere.(cf.)-term2-template"),

ua:template("etym-note-nume.propriu-term1-template",
    <template>
    	De la numele propriu&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'nume.propriu'] > term:nth-of-type(1):before"), "etym-note-nume.propriu-term1-template"),

ua:template("etym-note-nume.propriu-term2-template",
    <template>
    	&amp;nbsp;+ suf.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'nume.propriu'] > term:nth-of-type(2):before"), "etym-note-nume.propriu-term2-template"),

ua:template("etym-note-izvor-term-template",
    <template>
    	Explicații din izvor&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'izvor'] > term:nth-of-type(1):before"), "etym-note-izvor-term-template"),

ua:template("etym-note-trimitere.intrare-ptr-template",
    <template>
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'trimitere.intrare'] > ptr:before"), "etym-note-trimitere.intrare-ptr-template"),

ua:template("usg-before",
    <template>
        Indicații privind folosirea:&amp;nbsp;
		<datalist xmlns="http://www.w3.org/1999/xhtml" id="usage-options">
			<option label="" value="unknown"/>
			<option label="regional" value="geo"/>
			<option label="Ban." value="geo"/>
			<option label="Bucov." value="geo"/>
			<option label="Criș." value="geo"/>
			<option label="Dobr." value="geo"/>
			<option label="Maram." value="geo"/>
			<option label="Mold." value="geo"/>
			<option label="Munt." value="geo"/>
			<option label="Olt." value="geo"/>
			<option label="Transilv." value="geo"/>
			<option label="prin.Ban." value="geo"/>
			<option label="prin.Bucov." value="geo"/>
			<option label="prin.Criș." value="geo"/>
			<option label="prin.Dobr." value="geo"/>
			<option label="prin.Maram." value="geo"/>
			<option label="prin.Mold." value="geo"/>
			<option label="prin.Munt." value="geo"/>
			<option label="prin.Olt." value="geo"/>
			<option label="prin.Transilv." value="geo"/>
			<option label="în.Ban." value="geo"/>
			<option label="în.Bucov." value="geo"/>
			<option label="în.Criș." value="geo"/>
			<option label="în.Dobr." value="geo"/>
			<option label="în.Maram." value="geo"/>
			<option label="în.Mold." value="geo"/>
			<option label="în.Munt." value="geo"/>
			<option label="în.Olt." value="geo"/>
			<option label="în.Transilv." value="geo"/>
			<option label="Bucov." value="geo"/>
			<option label="Criș." value="geo"/>
			<option label="în.nordul" value="geo"/>
			<option label="în.sudul" value="geo"/>
			<option label="în.estul" value="geo"/>
			<option label="în.vestul" value="geo"/>
			<option label="în.sud-vestul" value="geo"/>
			<option label="în.sud-estul" value="geo"/>
			<option label="în.nord-vestul" value="geo"/>
			<option label="în.nord-estul" value="geo"/>
			<option label="prin.nordul" value="geo"/>
			<option label="prin.sudul" value="geo"/>
			<option label="prin.estul" value="geo"/>
			<option label="prin.vestul" value="geo"/>
			<option label="prin.sud-vestul" value="geo"/>
			<option label="prin.sud-estul" value="geo"/>
			<option label="prin.nord-vestul" value="geo"/>
			<option label="prin.nord-estul" value="geo"/>
			<option label="în.Țările.române." value="geo"/>
			<option label="din.Austria" value="geo"/>
			<option label="învechit" value="time"/>
			<option label="ieșit.din.uz" value="time"/>
			<option label="astăzi" value="time"/>
			<option label="în.Antichitate" value="time"/>
			<option label="în.capitalism" value="time"/>
			<option label="în.socialism" value="time"/>
			<option label="în.Evul.Mediu" value="time"/>
			<option label="la.sfârșitul.Evului.Mediu" value="time"/>
			<option label="în.monarhiile.constituționale" value="time"/>
			<option label="în.organizarea" value="time"/>
			<option label="A..plast." value="dom"/>
			<option label="Aeron." value="dom"/>
			<option label="Agric." value="dom"/>
			<option label="Agron." value="dom"/>
			<option label="Anat." value="dom"/>
			<option label="Apic." value="dom"/>
			<option label="Arheol." value="dom"/>
			<option label="Arhit." value="dom"/>
			<option label="Astron." value="dom"/>
			<option label="Biochim." value="dom"/>
			<option label="Biol." value="dom"/>
			<option label="Bis." value="dom"/>
			<option label="Bot." value="dom"/>
			<option label="Chim." value="dom"/>
			<option label="Ciber." value="dom"/>
			<option label="Cinem." value="dom"/>
			<option label="Comerț" value="dom"/>
			<option label="Constr." value="dom"/>
			<option label="Contab." value="dom"/>
			<option label="Cosm." value="dom"/>
			<option label="Cosmol." value="dom"/>
			<option label="Culgh." value="dom"/>
			<option label="Culin." value="dom"/>
			<option label="Ec." value="dom"/>
			<option label="Ec..pol." value="dom"/>
			<option label="Electron." value="dom"/>
			<option label="Electrotehn." value="dom"/>
			<option label="Entom." value="dom"/>
			<option label="Farm." value="dom"/>
			<option label="Farmac." value="dom"/>
			<option label="Fil." value="dom"/>
			<option label="Filoz./Filos." value="dom"/>
			<option label="Fin." value="dom"/>
			<option label="Fiz." value="dom"/>
			<option label="Fiziol." value="dom"/>
			<option label="Fon." value="dom"/>
			<option label="Fonol." value="dom"/>
			<option label="Fot." value="dom"/>
			<option label="Genet." value="dom"/>
			<option label="Geogr." value="dom"/>
			<option label="Geol." value="dom"/>
			<option label="Geom." value="dom"/>
			<option label="Gram." value="dom"/>
			<option label="Hot." value="dom"/>
			<option label="Iht." value="dom"/>
			<option label="Ind." value="dom"/>
			<option label="Inform." value="dom"/>
			<option label="Ist." value="dom"/>
			<option label="Jur." value="dom"/>
			<option label="Lingv." value="dom"/>
			<option label="Lit." value="dom"/>
			<option label="Log." value="dom"/>
			<option label="Mar." value="dom"/>
			<option label="Mat." value="dom"/>
			<option label="Mec." value="dom"/>
			<option label="Med." value="dom"/>
			<option label="Med..pop." value="dom"/>
			<option label="Med..vet." value="dom"/>
			<option label="Met." value="dom"/>
			<option label="Meteor." value="dom"/>
			<option label="Mil." value="dom"/>
			<option label="Mil." value="dom"/>
			<option label="Min." value="dom"/>
			<option label="Mineral." value="dom"/>
			<option label="Mitol." value="dom"/>
			<option label="Muz." value="dom"/>
			<option label="Nav." value="dom"/>
			<option label="Numism." value="dom"/>
			<option label="Opt." value="dom"/>
			<option label="Ornit." value="dom"/>
			<option label="Paleogr." value="dom"/>
			<option label="Pict." value="dom"/>
			<option label="Poligr." value="dom"/>
			<option label="Psih." value="dom"/>
			<option label="Radiofon." value="dom"/>
			<option label="Rel." value="dom"/>
			<option label="Statis." value="dom"/>
			<option label="Silv." value="dom"/>
			<option label="Șt..jur." value="dom"/>
			<option label="Șt..nat." value="dom"/>
			<option label="Tehn." value="dom"/>
			<option label="Telec." value="dom"/>
			<option label="Teol." value="dom"/>
			<option label="Text." value="dom"/>
			<option label="Tipogr." value="dom"/>
			<option label="Top." value="dom"/>
			<option label="TV." value="dom"/>
			<option label="Urban." value="dom"/>
			<option label="Zool." value="dom"/>
			<option label="argotic" value="register style"/>
			<option label="arhaic" value="register style"/>
			<option label="ca.epitet.pe.lângă" value="register style"/>
			<option label="creație.populară" value="register style"/>
			<option label="depreciativ" value="register style"/>
			<option label="emfatic" value="register style"/>
			<option label="eufemistic" value="register style"/>
			<option label="exclamativ" value="register style"/>
			<option label="familiar" value="register style"/>
			<option label="fig." value="register style"/>
			<option label="figurat" value="register style"/>
			<option label="glumeț" value="register style"/>
			<option label="în.argoul" value="register style"/>
			<option label="în.basme" value="register style"/>
			<option label="în.basme.și.superstiții" value="register style"/>
			<option label="în.cântece.de.leagăn" value="register style"/>
			<option label="în.colinde" value="register style"/>
			<option label="în.concepțiile.religioase" value="register style"/>
			<option label="în.credințele.mistice" value="register style"/>
			<option label="în.credințele.populare" value="register style"/>
			<option label="în.credințele.religioase" value="register style"/>
			<option label="în.descântece" value="register style"/>
			<option label="în.descântece.și.superstiții" value="register style"/>
			<option label="în.ghicitori" value="register style"/>
			<option label="în.imprecații" value="register style"/>
			<option label="în.invocații" value="register style"/>
			<option label="în.limba.literară" value="register style"/>
			<option label="în.limba.veche" value="register style"/>
			<option label="în.limbajul" value="register style"/>
			<option label="în.poezia.populară" value="register style"/>
			<option label="în.practicile.religioase" value="register style"/>
			<option label="în.predicile.bazate.pe.superstiții" value="register style"/>
			<option label="în.stilul" value="register style"/>
			<option label="în.supestiții" value="register style"/>
			<option label="în.textele" value="register style"/>
			<option label="ironic" value="register style"/>
			<option label="literar" value="register style"/>
			<option label="livresc" value="register style"/>
			<option label="peiorativ" value="register style"/>
			<option label="personificat" value="register style"/>
			<option label="poetic" value="register style"/>
			<option label="popular" value="register style"/>
			<option label="prin.exagerare" value="register style"/>
			<option label="adesea" value="plev"/>
			<option label="de.obicei" value="plev"/>
			<option label="mai.ales" value="plev"/>
			<option label="uneori" value="plev"/>
			<option label="neobișnuit" value="plev"/>
			<option label="rar" value="plev"/>
			<option label="curent" value="plev"/>
			<option label="mai.rar" value="plev"/>
			<option label="franțuzism" value="lang"/>
			<option label="germanism" value="lang"/>
			<option label="italienism" value="lang"/>
			<option label="grecism" value="lang"/>
			<option label="maghiarism" value="lang"/>
			<option label="latinism" value="lang"/>
			<option label="sârbism" value="lang"/>
			<option label="slavonism" value="lang"/>
			<option label="turcism" value="lang"/>
			<option label="adjectival" value="gram"/>
			<option label="adverbial" value="gram"/>
			<option label="artic." value="gram"/>
			<option label="cu.aglutinarea.art..pos." value="gram"/>
			<option label="cu.pron." value="gram"/>
			<option label="cu.schimbare.de.suf." value="gram"/>
			<option label="cu.valoare" value="gram"/>
			<option label="folosit.și.absol" value="gram"/>
			<option label="imper..lui" value="gram"/>
			<option label="impers." value="gram"/>
			<option label="invar." value="gram"/>
			<option label="la.comparativ" value="gram"/>
			<option label="la.f." value="gram"/>
			<option label="la.f..pl." value="gram"/>
			<option label="la.f..sg." value="gram"/>
			<option label="la.imper." value="gram"/>
			<option label="la.m." value="gram"/>
			<option label="la.m..pl." value="gram"/>
			<option label="la.m..sg." value="gram"/>
			<option label="la.n." value="gram"/>
			<option label="la.n..sg." value="gram"/>
			<option label="la.pers..1" value="gram"/>
			<option label="la.pers..2" value="gram"/>
			<option label="la.pers..3" value="gram"/>
			<option label="la.pl." value="gram"/>
			<option label="la.pl..cu.valoare.de.sg." value="gram"/>
			<option label="la.sg." value="gram"/>
			<option label="la.sg..cu.sens.colectiv" value="gram"/>
			<option label="la.sg..cu.sens.de.pl." value="gram"/>
			<option label="la.superlativ" value="gram"/>
			<option label="la.voc." value="gram"/>
			<option label="pl..lui" value="gram"/>
			<option label="substantivat" value="gram"/>
			<option label="complementul.indică" value="obj"/>
			<option label="cu.complement.intern" value="obj"/>
			<option label="cu.subiectul.....sau.un.echivalent.al.acestuia" value="subj"/>
			<option label="cu.subiectul.neexprimat,.subînțelegându-se" value="subj"/>
			<option label="cu.subiectul.personificat" value="subj"/>
			<option label="cu.subiectul.personificat" value="subj"/>
			<option label="cu.subiectului.exprimat.sau.subînțeles" value="subj"/>
			<option label="subiect.gramatical.sau.logic" value="subj"/>
			<option label="subiectul.este" value="subj"/>
			<option label="subiectul.indică" value="subj"/>
			<option label="atestat.prima.dată.în" value="hint"/>
			<option label="atestat.prima.dată.la" value="hint"/>
			<option label="ca.apelativ" value="hint"/>
			<option label="ca.epitet" value="hint"/>
			<option label="ca.s..pr." value="hint"/>
			<option label="ca.termen.de" value="hint"/>
			<option label="ca.termen.tehnic" value="hint"/>
			<option label="cea.mai.veche.atestare.ar.data" value="hint"/>
			<option label="creație.personală" value="hint"/>
			<option label="creație.spontană" value="hint"/>
			<option label="cu.aluzie.la" value="hint"/>
			<option label="cu.echivalente.ale.acestora" value="hint"/>
			<option label="cu.echivalente.ale.acestuia" value="hint"/>
			<option label="cu.elipsa" value="hint"/>
			<option label="cu.nuanță" value="hint"/>
			<option label="cu.sens" value="hint"/>
			<option label="cu.ortografie.etimologică" value="hint"/>
			<option label="cu.sensul" value="hint"/>
			<option label="cu.un.echivalent.al.acestora" value="hint"/>
			<option label="despre" value="hint"/>
			<option label="din.necesități.prozodice" value="hint"/>
			<option label="după.ortografia.germ." value="hint"/>
			<option label="eliptic" value="hint"/>
			<option label="folosit.independent" value="hint"/>
			<option label="folosit.la.adresa" value="hint"/>
			<option label="folosit.pentru.a.contrazice.categoric.pe.vorbitor" value="hint"/>
			<option label="folosit.pleonastic" value="hint"/>
			<option label="folosit.pleonastic.pe.lângă" value="hint"/>
			<option label="formă.coruptă" value="hint"/>
			<option label="formă.greşită" value="hint"/>
			<option label="formă.latinizantă" value="hint"/>
			<option label="formă.prescurtată" value="hint"/>
			<option label="greșit.în.dicționare" value="hint"/>
			<option label="impropriu" value="hint"/>
			<option label="în.comparații" value="hint"/>
			<option label="în.dialog" value="hint"/>
			<option label="în.dicționarele.din.trecut" value="hint"/>
			<option label="în.enumerări" value="hint"/>
			<option label="în.filozofia" value="hint"/>
			<option label="în.formă.prescurtată" value="hint"/>
			<option label="în.forme.compuse,.așezat.între" value="hint"/>
			<option label="în.opoziție.cu" value="hint"/>
			<option label="în.textele" value="hint"/>
			<option label="între.articol.şi.numeral.intervine.art..nehot." value="hint"/>
			<option label="la" value="hint"/>
			<option label="la.jocul.de" value="hint"/>
			<option label="la.unele.jocuri.de" value="hint"/>
			<option label="la.unele.sporturi" value="hint"/>
			<option label="nedefinit.mai.îndeaproape" value="hint"/>
			<option label="pleonastic" value="hint"/>
			<option label="precizat.prin" value="hint"/>
			<option label="prin.adaptare.la.sistemul.fonetic.popular" value="hint"/>
			<option label="prin.antiteză" value="hint"/>
			<option label="prin.confuzie" value="hint"/>
			<option label="prin.confuzie.cu" value="hint"/>
			<option label="prin.haplologie" value="hint"/>
			<option label="prin.metateză" value="hint"/>
			<option label="prin.sincopare" value="hint"/>
			<option label="probabil.din.necesități.prozodice" value="hint"/>
			<option label="pronunțat.cu" value="hint"/>
			<option label="scris.într-un.singur.cuvânt" value="hint"/>
			<option label="suspect" value="hint"/>
			<option label="construit.cu" value="coloc"/>
			<option label="construit.cu.corelativele" value="coloc"/>
			<option label="cu.determinarea.subînțeleasă" value="coloc"/>
			<option label="cu.forma.negativă.a.expr." value="coloc"/>
			<option label="cu.parafrazarea.expr." value="coloc"/>
			<option label="cu.parafrazarea.prov." value="coloc"/>
			<option label="cu.topica.schimbată" value="coloc"/>
			<option label="despre" value="coloc"/>
			<option label="determină" value="coloc"/>
			<option label="determinat.de" value="coloc"/>
			<option label="determinat.prin" value="coloc"/>
			<option label="în.componența.unor" value="coloc"/>
			<option label="în.concurență.cu" value="coloc"/>
			<option label="în.construcția" value="coloc"/>
			<option label="în.construcții" value="coloc"/>
			<option label="în.construcții.cu" value="coloc"/>
			<option label="în.construcțiile" value="coloc"/>
			<option label="în.corelație.cu" value="coloc"/>
			<option label="în.corelație.cu.el.însuși" value="coloc"/>
			<option label="în.expr." value="coloc"/>
			<option label="în.forma" value="coloc"/>
			<option label="în.forme.compuse" value="coloc"/>
			<option label="în.formele" value="coloc"/>
			<option label="în.formule" value="coloc"/>
			<option label="în.formule.de" value="coloc"/>
			<option label="în.loc.și.în.expr." value="coloc"/>
			<option label="în.loc..adj." value="loc. adj."/>
			<option label="în.loc..adv." value="loc. adv."/>
			<option label="în.loc..conj." value="loc. conj."/>
			<option label="în.loc..prep." value="loc. prep."/>
			<option label="în.loc..vb." value="loc. vb."/>
			<option label="în.prov." value="proverb"/>
			<option label="în.prov..și.în.zic." value="coloc"/>
			<option label="în.sint." value="coloc"/>
			<option label="în.zic..și.în.expr." value="coloc"/>
			<option label="indică" value="coloc"/>
			<option label="întărit.prin" value="coloc"/>
			<option label="precedă" value="coloc"/>
			<option label="precedă.noțiuni.temporale" value="coloc"/>
			<option label="precedă.ultimul.termen.al.unei.enumerări" value="coloc"/>
			<option label="precedat.de" value="coloc"/>
			<option label="precedat.de.calificative" value="coloc"/>
			<option label="precedat.de.complementul" value="coloc"/>
			<option label="urmat.de.complementul" value="coloc"/>
			<option label="precedat.de.corelativele" value="coloc"/>
			<option label="precedat.de.determinarea" value="coloc"/>
			<option label="precedat.de.determinări" value="coloc"/>
			<option label="precedat.de.determinări.care" value="coloc"/>
			<option label="precedat.de.determinări.introduse.prin" value="coloc"/>
			<option label="precedat.de.determinările" value="coloc"/>
			<option label="precedat.de.nume.de.identificare" value="coloc"/>
			<option label="precedat.de.o.comparație" value="coloc"/>
			<option label="precedat.de.propoziții.completive" value="coloc"/>
			<option label="precedat.de.propoziții.completive.care" value="coloc"/>
			<option label="precedat.de.propoziții.finale.care" value="coloc"/>
			<option label="precedat.de.propoziții.finale" value="coloc"/>
			<option label="precedat.de.propoziții.negative" value="coloc"/>
			<option label="precedat.de.propoziții.negative.care" value="coloc"/>
			<option label="prin.analogie.cu" value="coloc"/>
			<option label="repetat" value="coloc"/>
			<option label="și.în.sint." value="coloc"/>
			<option label="urmând.după.s..determinat" value="coloc"/>
			<option label="urmat.de" value="coloc"/>
			<option label="urmat.de.calificative" value="coloc"/>
			<option label="urmat.de.determinarea" value="coloc"/>
			<option label="urmat.de.determinări" value="coloc"/>
			<option label="urmat.de.determinări.care" value="coloc"/>
			<option label="urmat.de.determinări.introduse.prin" value="coloc"/>
			<option label="urmat.de.determinările" value="coloc"/>
			<option label="urmat.de.nume.de.identificare" value="coloc"/>
			<option label="urmat.de.o.comparație" value="coloc"/>
			<option label="urmat.de.propoziții.completive" value="coloc"/>
			<option label="urmat.de.propoziții.completive.care.precizează" value="coloc"/>
			<option label="urmat.de.propoziții.completive.introduse.prin.conj." value="coloc"/>
			<option label="urmat.de.propoziții.finale" value="coloc"/>
			<option label="urmat.de.propoziții.finale.care.precizează" value="coloc"/>
			<option label="urmat.de.propoziții.finale.introduse.prin.conj." value="coloc"/>
			<option label="urmat.de.propoziții.negative" value="coloc"/>
			<option label="urmat.de.propoziții.negative.care.precizează" value="coloc"/>
			<option label="urmat.de.propoziții.negative.introduse.prin.conj." value="coloc"/>
			<option label="urmează.după.s..determinat" value="coloc"/>
			<option label="dial." value="geo."/>
			<option label="abstr." value="sem"/>
			<option label="concr." value="sem"/>
			<option label="fig." value="sem"/>
			<option label="p..anal." value="sem"/>
			<option label="p..anal..cu" value="sem"/>
			<option label="p..ext." value="sem"/>
			<option label="p.gener." value="sem"/>
			<option label="p..restr." value="sem"/>
			<option label="p..spec." value="sem"/>
		</datalist>
        <input data-ua-ref="{@value}" size="30" list="usage-options" />
        <input data-ua-ref="{text()}" size="22" />      
    </template>
),
ua:attach-template(ua-dt:css-selector("usg:before"), "usg-before"),

ua:template("pc",
    <template>
        <select data-ua-ref="{text()}" contenteditable="false" style="width: 7px;">
            <option label="" value="" />
            <option label="\\," value="\\," />
            <option label=";" value=";" />
            <option label="și" value="și" />
            <option label="sau" value="sau" />
        </select>  
    </template>
),
ua:attach-template(ua-dt:css-selector("pc:before"), "pc"),

ua:template("usg-after",
    <template>
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("usg:after"), "usg-after"),

ua:template("quote",
    <template>
        Citat:&amp;nbsp;
        <textarea data-ua-ref="{text()}" cols="70" rows="7" data-contentType="text/plain" />
    </template>
),
ua:attach-template(ua-dt:css-selector("quote"), "quote"),

ua:template("bibl-before",
    <template>
        Izvor:&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false" style="width: 5px;">
            <option label="" value="unknown" />
            <option label="ap." value="ap." />
            <option label="cf." value="cf." />
            <option label="în" value="în" />
            <option label="▭" value="▭" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl:before"), "bibl-before"),

ua:template("bibl-ptr-before",
    <template>
        <datalist id="bibliographic-references">
            <option label="" value=""/>
        </datalist>
        <input data-ua-ref="{@target}" size="40" list="bibliographic-references" />
        <button onclick="{oxy:xquery('searchBibliographicReferences')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > ptr:before"), "bibl-ptr-before"),

ua:template("bibl-date-before",
    <template>
        <input data-ua-ref="{text()}" size="10" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > date:before"), "bibl-date-before"),

ua:template("bibl-citedRange-before",
    <template>
        <input data-ua-ref="{text()}" size="10" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > citedRange:before"), "bibl-citedRange-before"),

ua:template("cit-before",
    <template>
        Atestare:
        <button onclick="{oxy:xquery-update-action('insertCitElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector('cit:before'), "cit-before"),

ua:template("cit-not-first-of-type-before",
    <template>
        {
            ua:get-template('cit-before')
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector('cit:not( :first-of-type):before'), "cit-not-first-of-type-before"),

ua:template("gramGrp-before",
    <template>
        Categorie gramaticală:
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {local-name(parent::*) = 'sense' or count(parent::*/gramGrp) > 1};" />        
    </template>
),
ua:attach-template(ua-dt:css-selector("gramGrp:before"), "gramGrp-before"),

ua:template("pos-before",
    <template>
        \00000AParte de vorbire*:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="adj." value="adj." />
            <option label="adv." value="adv." />
            <option label="art." value="art." />
            <option label="conj." value="conj." />
            <option label="interj." value="interj." />
            <option label="num." value="num." />
            <option label="prep." value="prep." />
            <option label="pron." value="pron." />
            <option label="s." value="s." />
            <option label="subst." value="subst." />
            <option label="vb." value="vb." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos:before"), "pos-before"),

ua:template("gen-before",
    <template>
        Gen:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="f." value="f." />
            <option label="m." value="m." />
            <option label="m. şi f." value="m. şi f." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("gen:before"), "gen-before"),

ua:template("pos-s-gen-before",
    <template>
        Gen:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="f." value="f." />
            <option label="m." value="m." />
            <option label="m. si f." value="m. si f." />
            <option label="n." value="n." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 's.'] ~ gen:before"), "pos-s-gen-before"),

ua:template("pos-s-number-before",
    <template>
        Număr:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="" value="invar.">invar.</option>
            <option label="pl." value="pl." />
            <option label="pl. tant." value="pl. tant." />
            <option label="sg." value="sg." />
            <option label="sg. tant." value="sg. tant." />
            <option label="(la pl.)" value="(la pl.)" />
            <option label="mai ales la pl." value="mai ales la pl." />
            <option label="(sg.)" value="(sg.)" />
            <option label="(pl.)" value="(pl.)" />            
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 's.'] ~ number:before"), "pos-s-number-before"),

ua:template("pos-adj-number-before",
    <template>
        Număr:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="invar." value="invar." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'adj.'] ~ number:before"), "pos-adj-number-before"),

ua:template("case-before",
    <template>
        Caz:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="acuz." value="acuz." />
            <option label="dat." value="dat." />
            <option label="gen." value="gen." />
            <option label="gen.-dat." value="gen.-dat." />
            <option label="nom." value="nom." />
            <option label="voc." value="voc." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("case:before"), "case-before"),

ua:template("name-before",
    <template>
        Articulare:&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="(articulat)" value="(articulat)" />
            <option label="(mai ales art.)" value="(mai ales art.)" />
            <option label="articulat" value="articulat" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("name:before"), "name-before"),

ua:template("pos-adj-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="adj.-empty" />
            <option label="dem." value="adj.-dem." />
            <option label="inter.-rel." value="adj.-inter.-rel." />
            <option label="nehot." value="adj.-nehot." />
            <option label="pos." value="adj.-pos." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'adj.'] ~ subc:before"), "pos-adj-subc-before"),

ua:template("pos-art-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="adj." value="art.-adj." />
            <option label="hot." value="art.-hot." />
            <option label="nehot." value="art.-nehot." />
            <option label="pos." value="art.-pos." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'art.'] ~ subc:before"), "pos-art-subc-before"),

ua:template("pos-num-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="adv." value="num.-adv." />
            <option label="card." value="num.-card." />
            <option label="col." value="num.-col." />
            <option label="multipl." value="num.-multipl." />
            <option label="nehot." value="num.-nehot." />
            <option label="ord." value="num.-ord." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'num.'] ~ subc:before"), "pos-num-subc-before"),

ua:template("pos-pron-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="dem." value="pron.-dem." />
            <option label="inter.-rel." value="pron.-inter.-rel." />
            <option label="întăr." value="pron.-întăr." />
            <option label="neg." value="pron.-neg." />
            <option label="nehot." value="pron.-nehot." />
            <option label="pers." value="pron.-pers." />
            <option label="pos." value="pron.-pos." />
            <option label="refl." value="pron.-refl." />
            <option label="de politeţe" value="pron.-de politeţe" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'pron.'] ~ subc:before"), "pos-pron-subc-before"),

ua:template("multiple-number-before",
    <template>
        Număr:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="pl." value="pl." />
            <option label="sg." value="sg." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value='subst.'] ~ number:before, subc[value='pron.-dem.'] ~ number:before, subc[value='pron.-inter.-rel.'] ~ number:before, subc[value='pron.-nehot.'] ~ number:before, subc[value='pron.-pers.'] ~ number:before, subc[value='pron.-pos.'] ~ number:before, subc[value='pron.-de politeţe'] ~ number:before, subc[value='pron.-refl.'] ~ number:before"), "multiple-number-before"),

ua:template("multiple-per-before",
    <template>
        Persoană:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="pers. 1" value="pers. 1" />
            <option label="pers. 2" value="pers. 2" />
            <option label="pers. 3" value="pers. 3" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("subc[value='pron.-întăr.'] ~ per:before, subc[value='pron.-pers.'] ~ per:before, subc[value='pron.-pos.'] ~ per:before, subc[value='pron.-de politeţe'] ~ per:before, subc[value='pron.-refl.'] ~ per:before,
pos[value='adj.'] ~ subc[value='adj.-pos.'] ~ per:before"), "multiple-per-before"),

ua:template("pos-iType-before",
    <template>
        Conjugare:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="I" value="I" />
            <option label="II" value="II" />
            <option label="III" value="III" />
            <option label="IV" value="IV" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value='vb.'] ~ iType:before"), "pos-iType-before"),

ua:template("pos-vb-subc-before",
    <template>
        Diateză:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="absol." value="vb.-absol." />
            <option label="fact." value="vb.-fact." />
            <option label="intranz." value="vb.-intranz." />
            <option label="refl." value="vb.-refl." />
            <option label="refl. impers." value="vb.-refl. impers." />
            <option label="refl. pas." value="vb.-refl. pas." />
            <option label="refl. recipr." value="vb.-refl. recipr." />
            <option label="refl. unipers." value="vb.-refl. unipers." />
            <option label="tranz." value="vb.-tranz." />
            <option label="tranz. fact." value="vb.-tranz. fact." />
            <option label="intranz. şi refl." value="vb.-intranz. şi refl." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value='vb.'] ~ subc:before"), "pos-vb-subc-before"),

ua:template("multiple-form-bibl-after",
    <template>
        <button onclick="{oxy:execute-action-by-name('insertBiblElement')}" style="background-color: transparent; visibility: {count(bibl) = 0};"/>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unknown-accentuation'] > bibl:after, form[type = 'accentuation-variant'] > bibl:after, form[type = 'pronunciation'] > bibl:after, form[type = 'writing'] > bibl:after, form[type = 'grammatical-information-for-plural'] > bibl:after, form[type = 'grammatical-information-for-case'] > bibl:after, form[type = 'grammatical-information-for-verb'] > bibl:after, form[type = 'details-for-grammatical-information-for-verb'] > bibl:after, form[type = 'lexical-variant-section'] > bibl:after"), "multiple-form-bibl-after"),

ua:template("multiple-form-oVar",
    <template>
        Scris şi&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'writing'] > oVar, form[type = 'lexical-variant-section'] > oVar, form[type = 'abbreviation'] > oVar"), "multiple-form-oVar"),

ua:template("grammatical-information-for-verb-mood",
    <template>
        \00000AMod&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="ind." value="ind." />
            <option label="conjunct." value="conjunct." />
            <option label="cond.-opt." value="cond.-opt." />
            <option label="imper." value="imper." />
            <option label="ger." value="ger." />
            <option label="part." value="part." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb'] > mood"), "grammatical-information-for-verb-mood"),

ua:template("grammatical-information-for-verb-tns",
    <template>
        Timp&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="prez." value="prez." />
            <option label="imperf." value="imperf." />
            <option label="perf. s." value="perf. s." />
            <option label="perf. c." value="perf. c." />
            <option label="m. m. perf." value="m. m. perf." />
            <option label="viit." value="viit." />
            <option label="aor." value="aor." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb'] > tns"), "grammatical-information-for-verb-tns"),

ua:template("graphic-variant-before",
    <template>
        Variantă grafică&amp;nbsp;
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'graphic-variant']:before"), "graphic-variant-before"),

ua:template("graphic-variant-orth-before",
    <template>
        Scris şi:&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'graphic-variant'] > orth"), "graphic-variant-orth-before"),

ua:template("form-accentuation-before",
    <template>
        Accentuare&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="necunoscută" value="unknown-accentuation" />
            <option label="variantă de accentuare" value="accentuation-variant" />
        </select>
        <button onclick="{oxy:xquery-update-action('addAccentuationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unknown-accentuation']:before, form[type = 'accentuation-variant']:before"), "form-accentuation-before")
,
ua:template("form-articulation-before",
    <template>
        Articulat&amp;nbsp;
        <button onclick="{oxy:xquery-update-action('addArticulationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'articulation']:before"), "form-articulation-before")
,
ua:template("form-articulation-term-before",
    <template>
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'articulation'] > term:before"), "form-articulation-term-before")
,
ua:template("stress",
    <template>
        Variantă de accentuare&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
        \00000A
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" style="visibility: {count(following-sibling::usg) = 0};" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertBiblElement')}" style="visibility: {count(following-sibling::bibl) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("stress"), "stress"),

ua:template("form-pronunciation-before",
    <template>
        Pronunțare
        <button onclick="{oxy:xquery-update-action('addPronunciationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        \00000AIndicaţie de silabaţie
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="bisilabic" value="bisyllabic" />
            <option label="trisilabic" value="trisyllabic" />
        </select>
        <button onclick="{oxy:xquery-update-action('addFirstSyllabationElement')}" style="visibility: {count(syll) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstPronElement')}" style="visibility: {count(pron) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstPronunciationReferenceElement')}" style="visibility: {count(pRef) = 0};" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation']:before"), "form-pronunciation-before"),

ua:template("form-pronunciation-syll",
    <template>
        Silabația secvenței cu hiat&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('addSyllabationElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > syll"), "form-pronunciation-syll"),

ua:template("form-pronunciation-pron",
    <template>
        Pronunțarea cuvântului titlu străin&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('addPronElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > pron"), "form-pronunciation-pron"),

ua:template("form-pronunciation-pRef",
    <template>
        Pronunţat şi&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('addPronunciationReferenceElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > pRef"), "form-pronunciation-pRef"),

ua:template("form-writing-before",
    <template>
        Scriere
        <button onclick="{oxy:xquery-update-action('addWritingSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) > 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'writing']:before"), "form-writing-before"),

ua:template("form-abbreviation-before",
    <template>
        Abreviere
        <button onclick="{oxy:xquery-update-action('addAbbreviationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstoVarElement')}" style="visibility: {count(oVar) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'abbreviation']:before"), "form-abbreviation-before"),

ua:template("form-abbreviation-abbr",
    <template>
        Abreviat&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'abbreviation'] > abbr"), "form-abbreviation-abbr"),

ua:template("form-abbreviation-oVar",
    <template>
        {
            ua:get-template('multiple-form-oVar')
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'abbreviation'] > oVar"), "form-abbreviation-oVar"),

ua:template("form-grammatical-information-idno-first-of-type",
    <template>
        Indicații pentru&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="adj. / pron. / num. / s. / subst." value="grammatical-information-type-for-adj-et-al" />
            <option label="vb." value="grammatical-information-type-for-vb" />
        </select>   
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information'] > idno:first-of-type"), "form-grammatical-information-idno-first-of-type"),

ua:template("form-grammatical-information-idno-nth-of-type-2",
    <template>
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="pl." value="grammatical-information-subtype-for-pl" />
            <option label="caz" value="grammatical-information-subtype-for-case" />
            <option label="gen" value="grammatical-information-subtype-for-gender" />
        </select>   
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information'] > idno:nth-of-type(2)"), "form-grammatical-information-idno-nth-of-type-2"),

ua:template("form-grammatical-information-for-plural-number",
    <template>
        Pl.
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural'] > number"), "form-grammatical-information-for-plural-number"),

ua:template("form-grammatical-information-for-plural-gen-after",
    <template>
        <button onclick="{oxy:xquery-update-action('addGenElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural'] > gen:after"), "form-grammatical-information-for-plural-gen-after"),

ua:template("form-grammatical-information-for-gender-gen-before",
    <template>
        Gen&amp;nbsp;
        <select data-ua-ref="{@target}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="m" value="m" />
            <option label="f" value="f" />
            <option label="n" value="n" />
            <option label="m. şi f." value="m. şi f." />
        </select>   
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-gender'] > gen:before"), "form-grammatical-information-for-gender-gen-before"),

ua:template("form-grammatical-information-for-verb-per",
    <template>
        Persoană&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="pers. 1" value="pers. 1" />
            <option label="pers. 2" value="pers. 2" />
            <option label="pers. 3" value="pers. 3" />
            <option label="pers. 4" value="pers. 4" />
            <option label="pers. 5" value="pers. 5" />
            <option label="pers. 6" value="pers. 6" />
        </select>   
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb'] > per"), "form-grammatical-information-for-verb-per"),

ua:template("form-grammatical-information-for-verb-stress",
    <template>
        Variantă de accentuare&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
        <button onclick="{oxy:execute-action-by-name('insertStressElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb'] > stress"), "form-grammatical-information-for-verb-stress"),

ua:template("form-details-for-grammatical-information-for-verb-before",
    <template>
        Formă&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
        \00000A
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'details-for-grammatical-information-for-verb']:before"), "form-details-for-grammatical-information-for-verb-before"),

ua:template("form-lexical-variant-section-before",
    <template>
        Variantă lexicală&amp;nbsp;
        <button onclick="{oxy:xquery-update-action('addLexicalVariant')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:xquery-update-action('insertFirstSenseNumber')}" style="visibility: {count(ptr) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstAccentuationSection')}" style="visibility: {count(form[contains(' unknown-accentuation accentuation-variant ', @type)]) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstPronunciationSection')}" style="visibility: {count(form[@type = 'pronunciation']) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstWritingSection')}" style="visibility: {count(form[@type = 'writing']) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstAbbreviationSection')}" style="visibility: {count(form[@type = 'abbreviation']) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstGrammaticalInformationSection')}" style="visibility: {count(form[@type = 'grammatical-information']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'lexical-variant-section']:before"), "form-lexical-variant-section-before"),

ua:template("form-lexical-variant-before",
    <template>
        \00000AVariantă lexicală
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'lexical-variant']:before"), "form-lexical-variant-before"),

ua:template("form-flexionar-variant",
    <template>
        Var. flexionară&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-minuscule
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'flexionar-variant']"), "form-flexionar-variant"),

ua:template("form-multiple-ptr-after",
    <template>
        Număr de sens&amp;nbsp;
        {
            ua:get-template(oxy:get-template("combo",
                map {
                    "edit" := "@target",
                    "editable" := false,
                    "values" := string-join(//sense/@xml:id, ','),
                    "labels" := string-join(//sense/idno[1]/@n, ',')
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural'] > ptr:after, form[type = 'grammatical-information-for-case'] > ptr:after"), "form-multiple-ptr-after"),

ua:template("form-grammatical-information-for-verb-ptr-after",
    <template>
        Număr de sens&amp;nbsp;
        {
            ua:get-template(oxy:get-template("combo",
                map {
                    "edit" := "@target",
                    "editable" := false,
                    "values" := string-join(//sense/@xml:id, ','),
                    "labels" := string-join(//sense/idno[1]/@n, ',')
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb'] > ptr:after"), "form-grammatical-information-for-verb-ptr-after"),

ua:template("form-lexical-variant-section-ptr-after",
    <template>
        Număr de sens&amp;nbsp;
        {
            ua:get-template(oxy:get-template("combo",
                map {
                    "edit" := "@target",
                    "editable" := false,
                    "values" := string-join(//sense/@xml:id, ','),
                    "labels" := string-join(//sense/idno[1]/@n, ',')
                }            
            ))
        }
        <button onclick="{oxy:xquery-update-action('insertSenseNumber')}" style="background-color: transparent;" />        
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'lexical-variant-section'] > ptr:after"), "form-lexical-variant-section-ptr-after"),

ua:template("graphic-variant-not-first-of-type-before",
    <template>
        {
            ua:get-template('graphic-variant-before')
        }    
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'graphic-variant']:not( :first-of-type):before"), "graphic-variant-not-first-of-type-before"),


ua:template("form-grammatical-information-for-plural-before",
    <template>
        \00000AIndicaţii pentru plural
        <button onclick="{oxy:xquery-update-action('addGrammaticalInformationForPluralSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstGenElement')}" style="visibility: {count(gen) = 0};" />
        <button onclick="{oxy:xquery-update-action('insertFirstSenseNumber')}" style="visibility: {count(ptr) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false"/>
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural']:before"), "form-grammatical-information-for-plural-before"),

ua:template("form-grammatical-information-for-plural-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-plural-before')
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural']:not( :first-of-type):before "), "form-grammatical-information-for-plural-not-first-of-type-before"),

ua:template("form-grammatical-information-for-case-before",
    <template>
        \00000AIndicaţii pentru caz
        <button onclick="{oxy:xquery-update-action('addGrammaticalInformationForCaseSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:xquery-update-action('insertFirstSenseNumber')}" style="visibility: {count(ptr) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false"/>         
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-case']:before"), "form-grammatical-information-for-case-before"),

ua:template("form-grammatical-information-for-case-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-case-before')
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />       
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-case']:not( :first-of-type):before"), "form-grammatical-information-for-case-not-first-of-type-before"),

ua:template("form-grammatical-information-for-case-case",
    <template>
        <input data-ua-ref="{text()}" size="22" />      
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-case'] > case"), "form-grammatical-information-for-case-case"),

ua:template("form-grammatical-information-for-gender-before",
    <template>
        \00000AIndicaţii pentru gen
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationForGenderSection')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-gender']:before"), "form-grammatical-information-for-gender-before"),

ua:template("form-grammatical-information-for-gender-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-gender-before')
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />       
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-gender']:not( :first-of-type):before"), "form-grammatical-information-for-gender-not-first-of-type-before"),

ua:template("form-grammatical-information-for-verb-before",
    <template>
        \00000AIndicaţii pentru verb
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationForVerbSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstStressElement')}" style="visibility: {count(stress) = 0};" />
        <button onclick="{oxy:xquery-update-action('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false"/>
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb']:before"), "form-grammatical-information-for-verb-before"),

ua:template("form-grammatical-information-for-verb-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-verb-before')
        }
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb']:not( :first-of-type):before"), "form-grammatical-information-for-verb-not-first-of-type-before"),

ua:template("sense-currentEdited-value-before",
    <template>
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertReference')}" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("sense:before"), "sense-currentEdited-value-before"),

ua:template("sense-level-template",
    <template>
        Nivel:&amp;nbsp;
        <select data-ua-ref="{@n}" contenteditable="true" style="width: 17px;">
            <option label="◊" value="◊" />
            <option label="♦" value="♦" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > idno:first-of-type"), "sense-level-template"),

ua:template("idno-unitate-semantică-subsumată",
    <template>
        Unitate semantică subsumată:&amp;nbsp;        
        {
            $collocations-template
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[n = 'tip-unitate-semantică-subsumată']"), "idno-unitate-semantică-subsumată"),

ua:template("form-unitate-semantică-subsumată",
    <template>
        Conținut unitate semantică subsumată:&amp;nbsp;
        <input data-ua-ref="{text()}" size="81" />      
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > form[type = 'unitate-semantică-subsumată']:before"), "form-unitate-semantică-subsumată"),

ua:template("author-before",
    <template>
        Redactor*:&amp;nbsp;
        <select data-ua-ref="{text()}" contenteditable="false">
            <option label="" value="guest">guest</option>
            <option label="Anghelina Alexandru" value="anghelina.alexandru" />
            <option label="Busuioc Monica" value="monica.busuioc" />
            <option label="Bădic Dana-Melania" value="Dana-Melania" />
            <option label="Celac Victor" value="victor.celac" />
            <option label="Clim Marius" value="marius.clim" />
            <option label="Corbeanu Ramona Catalina" value="Catalina.Corbeanu" />
            <option label="Dincă Garofița" value="garofitad" />
            <option label="Dragomir Mioara" value="mioara.dragomir" />
            <option label="Florescu Cristina" value="cristina.florescu" />
            <option label="Geană Ionuț" value="igeana" />
            <option label="Haja Gabriela" value="Gabriela_Haja" />
            <option label="Hoinărescu Liliana" value="Lilianah" />
            <option label="Manea Laura" value="laura.manea" />
            <option label="Marin Mihaela" value="mihaela.marin" />
            <option label="Mihai Nicoleta" value="Nicoleta" />
            <option label="Mărănduc Cătălina" value="Catamara" />
            <option label="Nedea Raluca-Mihaela" value="r_nedea" />
            <option label="Niculescu-Gorpin Anabella-Gloria" value="Anabella" />
            <option label="Popescu Mihaela" value="msmihaelap" />
            <option label="Popuşoi Carolina" value="vozduh" />
            <option label="Pătrașcu Mădălin" value="madalin.patrascu" />
            <option label="Sterian Florin" value="FlorinSterian" />
            <option label="Tamba Isabella" value="isabelle.tamba" />
            <option label="Teste" value="tests" />
            <option label="Trif Radu-Nicolae" value="Radu" />
            <option label="Vasileanu Monica" value="monica.vasileanu" />
            <option label="Vasilescu Florin" value="FlorinV" />
        </select>
        <button onclick="{oxy:xquery-update-action('insertAuthorElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/author) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("author:before"), "author-before"),

ua:template("editor-before",
    <template>
        Revizor*:&amp;nbsp;
        <select data-ua-ref="{text()}" contenteditable="false">
            <option label="guest" value="guest" />
        </select>
        <button onclick="{oxy:xquery-update-action('insertEditorElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/editor) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("editor:before"), "editor-before"),

ua:template("creation",
    <template>
        Creat:&amp;nbsp;
    </template>
),
ua:attach-template(ua-dt:css-selector("creation"), "creation"),

ua:template("creation-date",
    <template>
        {concat(substring(@when-iso, 1, 22), ':', substring(@when-iso, 23))}
    </template>
),
ua:attach-template(ua-dt:css-selector("creation > date"), "creation-date"),

ua:template("revisionDesc",
    <template>
        Jurnal modificări
    </template>
),
ua:attach-template(ua-dt:css-selector("revisionDesc"), "revisionDesc"),

ua:template("change",
    <template>
        Modificat: {concat(substring(@when, 1, 22), ':', substring(@when, 23))}
    </template>
),
ua:attach-template(ua-dt:css-selector("change"), "change"),

ua:template("entry-form-headword-after",
    <template>
        {
            ua:get-template(oxy:get-template("ro.dlri.oxygen.templates.tree.TreeFormControl",
                map {
                    "edit" := "#text",
                    "width" := "1100",
                    "height" := "350",
                    "itemLabel" := "concat(idno[1]/@n, ' ', if (form) then concat(form, ' =') else (), ' ', string-join(def, ' '))"
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > form[type = 'headword']:after"), "entry-form-headword-after"),

ua:template("syll",
    <template>
        Despărțire în silabe:&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("syll"), "syll"),

ua:template("def",
    <template>
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertSynonym')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertAnalogy')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertAssociation')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertAntonym')}" data-showIcon="false" />
        \00000A
        <textarea data-ua-ref="{text()}" cols="70" rows="7" data-contentType="text/plain" />
        <button onclick="{oxy:xquery-update-action('insertDefElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteDefElement')}" style="background-color: transparent; visibility: {count(parent::*/def) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("def"), "def"),

ua:template("entry-form-headword-before",
    <template>
        Cuvânt titlu*:&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
        \00000ANumăr ordine omonime:&amp;nbsp;
        <input data-ua-ref="{@n}" size="2" />
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > form[type = 'headword'] > orth"), "entry-form-headword-before"),

ua:template("sense-form-before",
    <template>
        <input data-ua-ref="{text()}" size="108" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > form:before"), "sense-form-before")
