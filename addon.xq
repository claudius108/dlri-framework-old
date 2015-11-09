xquery version "3.0";

import module "http://expath.org/ns/user-agent/";

declare namespace ua-dt = "http://expath.org/ns/user-agent/datatype/";
declare namespace oxy = "http://oxygenxml.com/extensions/author/";

declare variable $ua:document := /;

declare variable $languages-template as element() :=
        <select data-ua-ref="{ua:context()/@xml:lang}" contenteditable="false">
            <option label="" value="" />
            <option label="alb." value="alb." />
            <option label="arom." value="arom." />
            <option label="bg." value="bg." />
            <option label="cat." value="cat." />
            <option label="ceh." value="ceh." />
            <option label="cr." value="cr." />
            <option label="dalm." value="dalm." />
            <option label="ebr." value="ebr." />
            <option label="engad." value="engad." />
            <option label="engl." value="engl." />
            <option label="esper." value="esper." />
            <option label="fr." value="fr." />
            <option label="friul." value="friul." />
            <option label="germ." value="germ." />
            <option label="gr." value="gr." />
            <option label="istr." value="istr." />
            <option label="it." value="it." />
            <option label="lat." value="lat." />
            <option label="lat. pop." value="lat. pop." />
            <option label="lat. mediev." value="lat. mediev." />
            <option label="magh." value="magh." />
            <option label="megl." value="megl." />
            <option label="m. gr." value="m. gr." />
            <option label="ngr." value="ngr." />
            <option label="pol." value="pol." />
            <option label="port." value="port." />
            <option label="prov." value="prov." />
            <option label="retorom." value="retorom." />
            <option label="rom." value="rom." />
            <option label="rus." value="rus." />
            <option label="săs." value="săs." />
            <option label="sard." value="sard." />
            <option label="sb." value="sb." />
            <option label="sicil." value="sicil." />
            <option label="sl." value="sl." />
            <option label="slavon." value="slavon." />
            <option label="slov." value="slov." />
            <option label="sp." value="sp." />
            <option label="tăt." value="tăt." />
            <option label="tc." value="tc." />
            <option label="tc. dial." value="tc. dial." />
            <option label="ţig." value="ţig." />
            <option label="ucr." value="ucr." />
            <option label="vegl." value="vegl." />
            <option label="v. sl." value="v. sl." />            
        </select>
;

declare variable $bibl-template as element() :=
    <bibl xmlns="http://www.tei-c.org/ns/1.0" type="">
        <ptr target="" />
        <date type="" />
        <citedRange />
    </bibl>
;

declare variable $cit-template as element() :=
    <cit xmlns="http://www.tei-c.org/ns/1.0">
        <quote />
        {$bibl-template}
    </cit>
;

declare variable $gramGrp-template as element() :=
   <gramGrp xmlns="http://www.tei-c.org/ns/1.0">
       <pos value="" />
   </gramGrp>
;

declare variable $lexical-variant-section-template as element() :=
<form xmlns="http://www.tei-c.org/ns/1.0" type="lexical-variant-section">
        <form type="lexical-variant" />
        {$gramGrp-template}
    </form>
;

declare variable $def-template as element() :=
    <def xmlns="http://www.tei-c.org/ns/1.0" n="" />
;

declare variable $sense-template as element() :=
    <sense xmlns="http://www.tei-c.org/ns/1.0" xml:id="id" level="">
        <idno n="tip-unitate-semantică-subsumată" type="" />
        <idno n="tip-proces-semantic" type="" />
        {$def-template}
        {$cit-template}
    </sense>
;

declare variable $certainty-template as element() :=
    <certainty xmlns="http://www.tei-c.org/ns/1.0" cert="" locus="value" />
;

declare variable $term-template as element() :=
    <term xmlns="http://www.tei-c.org/ns/1.0" xml:lang="" type="" subtype="" />
;

declare variable $analogy-template as element() :=
    <xr xmlns="http://www.tei-c.org/ns/1.0" type="analog">
        <ref target="">
            <oRef type="" />
            <lbl />
        </ref>
    </xr>
;

declare variable $association-template as element() :=
    <xr xmlns="http://www.tei-c.org/ns/1.0" type="asoc">
        <ref target="">
            <oRef type="" />
            <lbl />
        </ref>
    </xr>
;

declare variable $antonym-template as element() :=
    <xr xmlns="http://www.tei-c.org/ns/1.0" type="antonim">
        <ref target="">
            <oRef type="" />
            <lbl />
        </ref>
    </xr>
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

declare variable $semantical-process-template as element() :=
    <select data-ua-ref="{@type}" style="width: 22px;" contenteditable="false">
        <option label="abstr." value="abstr." />
        <option label="concr." value="concr." />
        <option label="fig." value="fig." />
        <option label="p. analogie" value="p. analogie" />
        <option label="p. analogie cu" value="p. analogie cu" />
        <option label="p. ext." value="p. ext." />
        <option label="p. gener." value="p. gener." />
        <option label="p. restr." value="p. restr." />
        <option label="p. spec." value="p. spec." />
        <option label="prin lărgirea sensului" value="prin lărgirea sensului" />
    </select>
;

declare variable $gr-minuscule as xs:string := "α,β,γ,δ,ε,ζ,η,θ,ι,κ,λ,μ,ν,ξ,ο,π,ρ,ς,σ,τ,υ,φ,χ,ψ,ω";

declare variable $ro-vocale-minuscule as xs:string := "á,é,í,ó,ú,ắ,ấ,î́";

declare variable $ro-vocale-majuscule as xs:string := "Á,É,Í,Ó,Ú,Ắ,Ấ,Î";

ua:action(
    "insertDefElement",
    map { 
        "name" := "Definiție",
        "smallIconPath" := "${framework}/resources/images/add.png"
    },   
    insert node $def-template after (following-sibling::xr | .)[last()]
),
ua:action(
    "deleteDefElement",
    map { 
        "name" := "Ștergere definiție",
        "smallIconPath" := "${framework}/resources/images/delete.png"
    },   
    delete nodes (following-sibling::xr | .)
),
ua:action(
    "insertCitElement",
    map { 
        "name" := "Atestare",
        "smallIconPath" := "${framework}/resources/images/add.png"
    },   
    insert node $cit-template after .
),
ua:action(
    "deleteElement",
    map { 
        "name" := "Ștergere",
        "smallIconPath" := "${framework}/resources/images/delete.png"       
    },   
    delete node .
),
ua:action(
    "addFirstLexicalVariant",
    map { 
        "name" := "Variantă lexicală"        
    },   
    insert node $lexical-variant-section-template after //entry/(sense | form[contains(' unknown-accentuation accentuation-variant ', @type)] |
    form[@type = 'pronunciation'] | form[@type = 'writing'] | form[@type = 'abbreviation'] | form[@type = 'grammatical-information'])[last()]
),
ua:action(
    "addLexicalVariant",
    map { 
        "name" := "Variantă lexicală",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node $lexical-variant-section-template after .
),
ua:action(
    "addEtymElement",
    map { 
        "name" := "Etimologie",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/etym.xml') after .
),
ua:action(
    "insertAuthorElement",
    map { 
        "name" := "Redactor",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/author.xml') after .
),
ua:action(
    "insertEditorElement",
    map { 
        "name" := "Revizor",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/editor.xml') after .
),
ua:action(
    "insertFirstUsgElement",
    map { 
        "name" := "Indicație folosire"       
    },   
    (
        if (count(def | orth | ref | syll | pron | pVar | number | case | mood | tns | per
                    | form[@type = 'details-for-grammatical-information-for-verb'] | stress | gramGrp | oVar
                    | form[@type = 'lexical-variant']) = 0)
        then (insert node doc('content-models/usg.xml') as first into .)
        else (),
        if (count(def | orth | ref | syll | pron | pVar | number | case | mood | tns | per
                    | form[@type = 'details-for-grammatical-information-for-verb'] | stress | gramGrp | oVar
                    | form[@type = 'lexical-variant']) gt 0)
        then (insert node doc('content-models/usg.xml') after (def | orth | ref | syll | pron | pVar | number | case | mood | tns | per
                    | form[@type = 'details-for-grammatical-information-for-verb'] | stress | gramGrp | oVar
                    | form[@type = 'lexical-variant'])[last()])
        else ()
    )      
),
ua:action(
    "insertUsgElement",
    map { 
        "name" := "Indicație folosire",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/usg.xml') after .
),
ua:action(
    "insertFirstBiblElement",
    map { 
        "name" := "Izvor",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    (
        if (count(syll | pron | pVar | usg | gen | case | ptr | mood | tns
                        | per | form[@type = 'details-for-grammatical-information-for-verb']
                        | stress | oVar | form[@type = 'flexionar-variant']
                        | form[contains(' unknown-accentuation accentuation-variant ', @type)]
                        | form[@type = 'pronunciation'] | form[@type = 'writing']
                        | form[@type = 'abbreviation'] | form[@type = 'grammatical-information'] | mentioned) = 0)
        then (insert node $bibl-template as first into .)
        else (),
        if (count(syll | pron | pVar | usg | gen | case | ptr | mood | tns
                        | per | form[@type = 'details-for-grammatical-information-for-verb']
                        | stress | oVar | form[@type = 'flexionar-variant']
                        | form[contains(' unknown-accentuation accentuation-variant ', @type)]
                        | form[@type = 'pronunciation'] | form[@type = 'writing']
                        | form[@type = 'abbreviation'] | form[@type = 'grammatical-information'] | mentioned) gt 0)
                        then (insert node $bibl-template after (syll | pron | pVar | usg | gen | case | ptr | mood | tns
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
        "smallIconPath" := "${framework}/resources/images/add.png"       
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
        "smallIconPath" := "${framework}/resources/images/add.png"
    },   
    insert node doc('content-models/synonym.xml') after .
),
ua:action(
    "insertAnalogy",
    map { 
        "name" := "Analogie",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    (
        if (local-name() = 'xr')
        then insert node $analogy-template after .
        else (),
        if (local-name() = 'def')
        then insert node $analogy-template after (following-sibling::xr[@type = ('analog', 'syn')] | .)[last()]
        else ()
     )    
),
ua:action(
    "insertAssociation",
    map { 
        "name" := "Asociație",
        "smallIconPath" := "${framework}/resources/images/add.png"
    },
    (
        if (local-name() = 'xr')
        then insert node $association-template after .
        else (),
        if (local-name() = 'def')
        then insert node $association-template after (following-sibling::xr[@type = ('analog', 'syn', 'asoc')] | .)[last()]
        else ()
     )     
),
ua:action(
    "insertAntonym",
    map { 
        "name" := "Antonim",
        "smallIconPath" := "${framework}/resources/images/add.png"
    },
    (
        if (local-name() = 'xr')
        then insert node $antonym-template after .
        else (),
        if (local-name() = 'def')
        then insert node $antonym-template after (following-sibling::xr[@type = ('analog', 'syn', 'asoc', 'antonim')] | .)[last()]
        else ()
     )     
),
ua:action(
    "insertReference",
    map { 
        "name" := "Trimitere"        
    },   
    insert node doc('content-models/reference.xml') after (usg | xr[@type = 'trimitere'] | def)[last()]
),
ua:action(
    "addGramGrp",
    map { 
        "name" := "Cat. gram.",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },
    (
        if (local-name() = 'sense')
        then insert node $gramGrp-template as first into .
        else (),
        if (local-name() != 'sense')
        then insert node $gramGrp-template after .
        else ()
     )
),
ua:action(
    "addFirstAccentuationSection",
    map { 
        "name" := "Accentuare"        
    },
    (
        if (local-name(.) = 'etym')
        then (insert node doc('content-models/accentuation.xml') after //entry/sense[last()])
        else (),
        if (local-name(.) != 'etym')
        then (insert node doc('content-models/accentuation.xml') after (form[type = 'lexical-variant'] | gramGrp | usg | ptr)[last()])
        else ()
    )
),
ua:action(
    "addAccentuationSection",
    map { 
        "name" := "Accentuare",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/accentuation.xml') after .
),
ua:action(
    "addFirstPronunciationSection",
    map { 
        "name" := "Pronunțare"       
    },
    (
        if (local-name() = 'etym')
        then (insert node doc('content-models/pronunciation.xml') after //entry/(sense | form[contains(' unknown-accentuation accentuation-variant ', @type)])[last()])
        else (),
        if (local-name() != 'etym')
        then (insert node doc('content-models/pronunciation.xml') after (form[type = 'lexical-variant'] | gramGrp | usg | ptr | form[contains(' unknown-accentuation
            accentuation-variant ', @type)])[last()])
        else ()
     )
),
ua:action(
    "addPronunciationSection",
    map { 
        "name" := "Pronunțare",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/pronunciation.xml') after .
),
ua:action(
    "addAbbreviationSection",
    map { 
        "name" := "Abreviere"
    },   
    insert node doc('content-models/accentuation.xml') after //entry/(sense | form[@type = 'lexical-variant-section'])[last()]
),
ua:action(
    "addFirstGrammaticalInformationSection",
    map { 
        "name" := "Indicații gramaticale"        
    },
    (
        if (local-name() = 'etym')
        then (insert node doc('content-models/grammatical-information.xml') after //entry/(sense | form[contains(' unknown-accentuation accentuation-variant ', @type)] |
            form[@type = 'pronunciation'] | form[@type = 'writing'] | form[@type = 'abbreviation'])[last()])
        else (),
        if (local-name() != 'etym')
        then (insert node doc('content-models/grammatical-information.xml') after (form[type = 'lexical-variant'] | gramGrp | usg | ptr | form[contains(' unknown-accentuation
            accentuation-variant ', @type)] | form[@type = 'pronunciation'] | form[@type = 'writing'] | form[@type = 'abbreviation'])[last()])
        else ()
    )
),
ua:action(
    "addGrammaticalInformationSection",
    map { 
        "name" := "Indicații gramaticale",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },
    (
        if (local-name() = 'form' and @type = 'grammatical-information')
        then (insert node doc('content-models/grammatical-information.xml') after .)
        else (),
        if (local-name() = 'etym')
        then (insert node doc('content-models/grammatical-information.xml') after (term | ptr)[last()])
        else ()
    )    
),
ua:action(
    "addFirstSyllabationElement",
    map { 
        "name" := "Silabație hiat"        
    },   
    insert node doc('content-models/syll.xml') as first into .
),
ua:action(
    "addSyllabationElement",
    map { 
        "name" := "Silabație hiat",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/syll.xml') after .
),
ua:action(
    "addFirstPronElement",
    map { 
        "name" := "Pron. cuvânt străin"       
    },   
    (
        if (count(syll) = 0)
        then (insert node doc('content-models/pron.xml') as first into .)
        else (),
        if (count(syll) gt 0)
        then (insert node doc('content-models/pron.xml') after syll[last()])
        else ()
    )      
),
ua:action(
    "addPronElement",
    map { 
        "name" := "Pron. cuvânt străin",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/pron.xml') after .
),
ua:action(
    "addFirstPVarElement",
    map { 
        "name" := "Pronunţat şi"       
    },   
    (
        if (count(syll | pron) = 0)
        then (insert node doc('content-models/pVar.xml') as first into .)
        else (),
        if (count(syll | pron) gt 0)
        then (insert node doc('content-models/pVar.xml') after (syll | pron)[last()])
        else ()
    )      
),
ua:action(
    "addPVarElement",
    map { 
        "name" := "Pronunţat şi",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/pVar.xml') after .
),
ua:action(
    "addFirstWritingSection",
    map { 
        "name" := "Scriere"        
    },
    (
        if (local-name() = 'etym')
        then (insert node doc('content-models/writing.xml') after //entry/(sense | form[contains(' unknown-accentuation accentuation-variant ', @type)] |
            form[@type = 'pronunciation'])[last()])
        else (),
        if (local-name() != 'etym')
        then (insert node doc('content-models/writing.xml') after (form[type = 'lexical-variant'] | gramGrp | usg | ptr | form[contains(' unknown-accentuation
            accentuation-variant ', @type)] | form[@type = 'pronunciation'])[last()])
        else ()
    )
),
ua:action(
    "addWritingSection",
    map { 
        "name" := "Scriere",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/writing.xml') after .
),
ua:action(
    "addFirstAbbreviationSection",
    map { 
        "name" := "Abreviere"        
    },
    (
        if (local-name() = 'etym')
        then (insert node doc('content-models/abbreviation.xml') after //entry/(sense | form[contains(' unknown-accentuation accentuation-variant ', @type)] |
            form[@type = 'pronunciation'] | form[@type = 'writing'])[last()])
        else (),
        if (local-name() != 'etym')
        then (insert node doc('content-models/abbreviation.xml') after (form[type = 'lexical-variant'] | gramGrp | usg | ptr | form[contains(' unknown-accentuation
            accentuation-variant ', @type)] | form[@type = 'pronunciation'] | form[@type = 'writing'])[last()])
        else ()
     )
),
ua:action(
    "addAbbreviationSection",
    map { 
        "name" := "Abreviere",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/abbreviation.xml') after .
),
ua:action(
    "addGrammaticalInformationForPluralSection",
    map { 
        "name" := "Plural",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/grammatical-information-for-plural.xml') after .
),
ua:action(
    "addFirstGenElement",
    map { 
        "name" := "Gen"        
    },   
    insert node doc('content-models/gen.xml') after (number | usg | gramGrp | ptr)[last()]
),
ua:action(
    "addGenElement",
    map { 
        "name" := "Gen",
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/gen.xml') after .
),
ua:action(
    "insertFirstSenseNumber",
    map { 
        "name" := "Nr. de sens"       
    },   
    (
        if (count(usg | gen | case | form[@type = 'details-for-grammatical-information-for-verb'] | gramGrp | form[@type = 'lexical-variant']) = 0)
        then (insert node doc('content-models/sense-number-pointer.xml') as first into .)
        else (),
        if (count(usg | gen | case | form[@type = 'details-for-grammatical-information-for-verb'] | gramGrp | form[@type = 'lexical-variant']) gt 0)
        then (insert node doc('content-models/sense-number-pointer.xml') after (usg | gen | case | form[@type = 'details-for-grammatical-information-for-verb'] | gramGrp | form[@type = 'lexical-variant'])[last()])
        else ()
    )      
),
ua:action(
    "insertSenseNumber",
    map { 
        "name" := "Nr. de sens",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/sense-number-pointer.xml') after .
),
ua:action(
    "addGrammaticalInformationForCaseSection",
    map { 
        "name" := "Plural",
        "smallIconPath" := "${framework}/resources/images/add.png"        
    },   
    insert node doc('content-models/grammatical-information-for-case.xml') after .
),
ua:action(
    "addGrammaticalInformationForVerbSection",
    map { 
        "name" := "Verb",
        "smallIconPath" := "${framework}/resources/images/add.png"
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
        "smallIconPath" := "${framework}/resources/images/add.png"       
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
        "smallIconPath" := "${framework}/resources/images/add.png"       
    },   
    insert node doc('content-models/oVar.xml') after .
),
ua:action(
    "addGrammaticalInformationForGenderSection",
    map { 
        "name" := "Gen",
        "smallIconPath" := "${framework}/resources/images/add.png"
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
    "derivationBaseAnnotator",
    map { 
        "name" := "Bază de derivare"      
    },   
    replace node . with
        <xr xmlns="http://www.tei-c.org/ns/1.0" type="derivation-base">
            <ref target="">
                <oRef type="" />
                <lbl />
            </ref>
        </xr>
),
ua:action(
    "searchBibliographicReference",
    map { 
        "name" := "Izvor"       
    },   
    oxy:execute-action-by-class("ro.dlri.oxygen.templates.bibliographicReference.SelectBibliographicReferenceDialog")
),
ua:action(
    "validate",
    map { 
        "name" := "Validare"       
    },   
    oxy:execute-action-by-class("ro.dlri.oxygen.templates.validationDialog.ValidateDialogComponent")
),
ua:action(
    "render",
    map { 
        "name" := "Redare"        
    },   
    oxy:execute-action-by-class("ro.dlri.oxygen.templates.renderingDialog.RenderingDialogComponent")
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
            'art.-pos.', 'num.-card.', 'num.-col.', 'num.-multipl.', 'num.-nehot.', 'num.-ord.', 'vb.-(folosit şi absol.)', 'vb.-absol.',
            'vb.-fact.">fact.', 'vb.-intranz.', 'vb.-refl.', 'vb.-refl. impers.', 'vb.-refl. pos.', 'vb.-refl. recipr.', 'vb.-refl. unipers.',
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
        then (delete nodes following-sibling::form[@type = 'unitate-semantică-subsumată'])
        else (),
        if (@n = 'tip-unitate-semantică-subsumată' and string-length(@type) > 0)
        then
            (
                delete nodes following-sibling::form[@type = 'unitate-semantică-subsumată']
                ,
                insert node <form xmlns="http://www.tei-c.org/ns/1.0" type="unitate-semantică-subsumată" /> after parent::*/idno[last()]
            )        
        else (),        
        
        if (@type = 'cuvântul titlu-element moştenit-etimon atestat')
        then
            (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[1]/@cert with 'high',
                replace value of node ./following-sibling::*[2]/@xml:lang with 'Lat.',
                replace value of node ./following-sibling::*[2]/@type with ''
            )
        else (),
        if (@type = 'cuvântul titlu-element moştenit-etimon neatestat')
        then
            (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[1]/@cert with 'low',
                replace value of node ./following-sibling::*[2]/@xml:lang with 'Lat.',
                replace value of node ./following-sibling::*[2]/@type with '' 
            )
        else (),        
        if (@type = 'cuvântul titlu-element de substrat')
        then
            (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, doc('content-models/mentioned.xml')) after .
            )
        else (),  
        if (@type = 'cuvântul titlu-formație internă-derivat-cu prefix')
        then
            (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'prefix',
                replace value of node ./following-sibling::*[3]/@type with 'base'
            )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-derivat-cu sufix')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'base',
                replace value of node ./following-sibling::*[3]/@type with 'sufix'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-derivat-cu prefix şi sufix')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'prefix',
                replace value of node ./following-sibling::*[3]/@type with 'base',
                replace value of node ./following-sibling::*[4]/@type with 'sufix'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-compus-element de compunere + cuvânt bază')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'component-element',
                replace value of node ./following-sibling::*[3]/@type with 'base'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-compus-cuvânt bază + element de compunere')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'base',
                replace value of node ./following-sibling::*[3]/@type with 'component-element'
        )
        else (),              
        if (@type = 'cuvântul titlu-formație internă-compus-din mai multe cuvinte de bază')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'base',
                replace value of node ./following-sibling::*[3]/@type with 'base'
        )
        else (),
        if (@type = 'cuvântul titlu-formație internă-compus-formație savantă din latină')
        then (
                delete nodes following-sibling::*,
                insert nodes ($term-template, $term-template) after .,
                replace value of node ./following-sibling::*[1]/@type with 'latin-base',
                replace value of node ./following-sibling::*[2]/@type with 'added-base'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-derivat regresiv')
        then (
                delete nodes following-sibling::*, 
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'regressive-derivate'
        )
        else (),                
        if (@type = 'cuvântul titlu-formație internă-derivat postverbal')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'postverbal-derivate'
        )
        else (),
        if (@type = 'cuvântul titlu-formație internă-trimitere-V.')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, doc('content-models/ptr.xml')) after .,
                replace value of node ./following-sibling::*[1]/@cert with 'low'
             )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-trimitere-Cf.')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, doc('content-models/ptr.xml')) after .
             )
        else (),     
        if (starts-with(@type, 'cuvântul titlu-formație internă-trimitere-De la-'))
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .
        )
        else (),         
        if (starts-with(@type, 'cuvântul titlu-formație internă-trimitere-Din-'))
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-prescurtare')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'abbreviation'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-contaminare-cu un element-în care primul element este')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'contamination-element'
        )
        else (),         
        if (@type = 'cuvântul titlu-formație internă-contaminare-cu un element-în care unul dintre elemente este')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'contamination-element'
        )
        else (),            
        if (@type = 'cuvântul titlu-formație internă-contaminare-cu două sau mai multe elemente')
        then (
                delete nodes following-sibling::*, 
                insert nodes ($certainty-template, $term-template, $term-template, $term-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'contaminated-element',
                replace value of node ./following-sibling::*[3]/@type with 'alternative-contaminated-element',
                replace value of node ./following-sibling::*[4]/@type with 'contamination-element',
                replace value of node ./following-sibling::*[5]/@type with 'alternative-contamination-element'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-calc')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'calc'
        )
        else (), 
                 if (@type = 'cuvântul titlu-formație internă-onomatopee')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@type with 'onomatopoeia'
        )
        else (),
        if (@type = 'cuvântul titlu-formație internă-contragere')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'contragere'
        )
        else (),           
        if (starts-with(@type, 'cuvântul titlu-formație internă-izolare-'))
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-singular refăcut după plural')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'singular-dupa-plural'
        )
        else (),          
        if (@type = 'cuvântul titlu-formație internă-formație onomatopeică')
        then ( 
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'formatie-onomatopeica'
        )
        else (), 
        if (@type = 'cuvântul titlu-formație internă-formație spontană de la')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'formatie-spontana'
        )
        else (),         
        if (@type = 'cuvântul titlu-formație internă-prin figură etimologică de la')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'figura-etimologica'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-din formulă de urare')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'formula-urare'
        )
        else (),        
        if (@type = 'cuvântul titlu-formație internă-format după')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'format după'
        )
        else (),
        if (@type = 'cuvântul titlu-formație internă-denumire comercială')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'denumire comercială'
        )
        else (),        
        if (@type = 'cuvântul titlu-element extern-împrumut-etimon sigur')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .
             )
        else (),        
        if (@type = 'cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (necunoscut)')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .
             )
        else (),         
        if (@type = 'cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (reconstruit) v. sl. *')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .,
                replace value of node ./following-sibling::*[2]/@xml:lang with 'v. sl.'
        )
        else (),
        if (@type = 'cuvântul titlu-element extern-calc')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .
             )
        else (),        
        if (@type = 'cuvântul titlu-element extern-trimitere')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, doc('content-models/mentioned.xml')) after .
             )
        else (), 
        if (@type = 'cuvântul titlu-element necunoscut')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, $term-template) after .
        )
        else (),        
        if (@type = 'unul sau mai multe sensuri-explicarea sensului-cf. izvor')
        then (
                delete nodes following-sibling::*,
                insert nodes (doc('content-models/ptr.xml'), $bibl-template) after .
             )
        else (),  
        
        
        
                
        
        
        if (starts-with(@type, 'variantă-directă-prin accidente fonetice-'))
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1]/@type with 'lexical-variant'
        )
        else (),        
        if (@type = 'variantă-directă-cu schimbare de suf.')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1] with 'Cu schimbare de sufix'
        )
        else (), 
        
        
        
                
                      
        
                    
    
        if (@type = 'empty')
        then (delete nodes following-sibling::*)
        else (),    
        if (@type = 'etymon-type-for-multiple-senses')
        then (delete nodes following-sibling::*, insert nodes ($certainty-template, doc('content-models/idno.xml'),
            doc('content-models/sense-number-pointer.xml'), doc('content-models/idno.xml')) after .)
        else (),   
        if (@type = ('multiple-senses-etymon-subtype-for-cf etimon', 'multiple-senses-etymon-subtype-for-cf. şi etimon'))
        then (delete nodes following-sibling::*, insert node doc('content-models/ptr.xml') after .)
        else (),
        if (@type = 'etymon-type-for-multiple-lexical-variants')
        then (
                delete nodes following-sibling::*,
                insert nodes ($certainty-template, doc('content-models/idno.xml'), $term-template, doc('content-models/idno.xml')) after .,
                replace value of node ./following-sibling::*[3]/@type with 'lexical-variant'
        )
        else (),        
        if (@type = ('lexical-variant-subtype-for-directă', 'lexical-variant-subtype-for-trimitere'))
        then (delete nodes following-sibling::*, insert node doc('content-models/idno.xml') after .)
        else (),        
        if (@type = 'directă-subtype-for-etimon variantă')
        then (delete nodes following-sibling::*, insert node doc('content-models/idno.xml') after .)
        else (),
        if (@type = ('etimon variantă-subtype-for-atestat', 'etimon variantă-subtype-for-reconstruit'))
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .
        )
        else (),
        if (@type = 'directă-subtype-for-sg. refăcut după plural')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1] with 'Sg. refăcut după plural'
        )
        else (),        
        if (@type = 'directă-subtype-for-prin etimologie populară')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1] with 'Prin etimologie populară'
        )
        else (),
        if (@type = 'directă-subtype-for-refăcut după forma articulată')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1] with 'Refăcut după forma articulată'
        )
        else (),
        if (@type = 'directă-subtype-for-refăcut după sg. art.')
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .,
                replace value of node ./following-sibling::*[1] with 'Refăcut după singular articulat'
        )
        else (),
        if (@type = 'trimitere-subtype-for-cf. cuvânt')
        then (delete nodes following-sibling::*, insert node doc('content-models/ptr.xml') after .)
        else (),        
        if (@type = 'trimitere-subtype-for-cf. izvor')
        then (delete nodes following-sibling::*, insert node $bibl-template after .)
        else (),
        if (@type = ('directă-subtype-for-sg. refăcut după pluralul', 'directă-subtype-for-prin apropiere de', 'directă-subtype-for-prin derivare cu sufix',
            'directă-subtype-for-sub influenţa', 'directă-subtype-for-etimologie populară prin apropiere de', 'directă-subtype-for-din lat.'))
        then (
                delete nodes following-sibling::*,
                insert node $term-template after .
        )
        else (),        
        if (@type = 'grammatical-information-type-for-adj-et-al')
        then (delete nodes following-sibling::*, insert node doc('content-models/idno.xml') after .)
        else (),
        if (@type = 'grammatical-information-type-for-vb')
        then (delete nodes following-sibling::*, insert node doc('content-models/grammatical-information-for-verb.xml') after .)
        else (),
        if (@type = 'grammatical-information-subtype-for-pl')
        then (delete nodes following-sibling::*, insert node doc('content-models/grammatical-information-for-plural.xml') after .)
        else (),        
        if (@type = 'grammatical-information-subtype-for-case')
        then (delete nodes following-sibling::*, insert node doc('content-models/grammatical-information-for-case.xml') after .)
        else (),
        if (@type = 'grammatical-information-subtype-for-gender')
        then
            (
                delete nodes following-sibling::*
                ,
                insert node doc('content-models/grammatical-information-for-gender.xml') after .
            )
        else (),
        if (@type != '')
        then ()
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
        "smallIconPath" := "${framework}/resources/images/add.png"
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
        "smallIconPath" := "${framework}/resources/images/add.png"
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
        "smallIconPath" := "${framework}/resources/images/add.png"
    }, 
    (
        insert node $term-template after .,
        replace value of node ./following-sibling::*[1]/@type with 'added-base'
    )
),
ua:action(
    "changedValueAttrForUsgElement",
    map { 
        "name" := "changedValueAttrForUsgElement"
    }, 
    (replace value of node ./@type with doc('content-models/usg-datalist.xml')/*/*[@label = ./@value]/@value/string())
),
ua:action(
    "deleteContaminationElement",
    map { 
        "name" := "Ștergere",
        "smallIconPath" := "${framework}/resources/images/delete.png"        
    },   
    delete nodes (. | preceding-sibling::term[1])
),
ua:action(
    "addEtymonTranslation",
    map { 
        "name" := "Traducere etimon"        
    },   
    (insert node $term-template as last into ., replace value of node term[last()]/@type with 'translation')
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

ua:add-event-listener($ua:document, "load", oxy:execute-action-by-name('Author/No_tags')),
ua:add-event-listener($ua:document, "load", oxy:execute-action-by-class('ro.kuberam.oxygen.addonBuilder.actions.KeepAuthorView')),

ua:template("tei-before",
    <template>
        <button onclick="{oxy:execute-action-by-name('validate')}" />
        <button onclick="{oxy:execute-action-by-name('render')}" />
    </template>
),
ua:attach-template(ua-dt:css-selector('TEI:before'), "tei-before"),

ua:template("grammatical-information-form",
    <template>
        Indicații gramaticale
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
        \00000A
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information']:before"), "grammatical-information-form"),

ua:template("trimitere-before",
    <template>
        Trimitere (cuvânt titlu | nr. ordine omonim | nr. ordine sens)&amp;nbsp;
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'trimitere']:before"), "trimitere-before"),

ua:template("analog-before",
    <template>
        Analogie (cuvânt titlu | nr. ordine omonim | nr. ordine sens)&amp;nbsp;
        <button onclick="{oxy:execute-action-by-name('insertAnalogy')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'analog']:before"), "analog-before"),

ua:template("asoc-before",
    <template>
        Asociație (cuvânt titlu | nr. ordine omonim | nr. ordine sens)&amp;nbsp;
        <button onclick="{oxy:execute-action-by-name('insertAssociation')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'asoc']:before"), "asoc-before"),

ua:template("antonim-before",
    <template>
        În  opoziţie cu (cuvânt titlu | nr. ordine omonim | nr. ordine sens)&amp;nbsp;
        <button onclick="{oxy:execute-action-by-name('insertAntonym')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'antonim']:before"), "antonim-before"),

ua:template("etym-before",
    <template>
        \00000A Etimologie&amp;nbsp;
        <button onclick="{oxy:execute-action-by-name('addEtymElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertCfElements')}" style="visibility: {idno[1]/@type = 'cuvântul titlu-element de substrat'};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" data-showIcon="false" style="visibility: {idno[1]/@type = 'cuvântul titlu-element de substrat'};" />
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationSection')}" data-showIcon="false" style="visibility: {idno[starts-with(@type, 'cuvântul titlu-formație internă-trimitere-')] and count(form[@type = 'grammatical-information']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addEtymonTranslation')}" style="visibility: {idno[1]/@type = 'etymon-type-for-multiple-lexical-variants' and count(term[@type = 'translation']) = 0};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym:before"), "etym-before"),

ua:template("etym-first-of-type-before",
    <template>
        <button onclick="{oxy:execute-action-by-name('addFirstAccentuationSection')}" style="visibility: {count(//entry/form[contains(' unknown-accentuation accentuation-variant ', @type)]) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstPronunciationSection')}" style="visibility: {count(//entry/form[@type = 'pronunciation']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstWritingSection')}" style="visibility: {count(//entry/form[@type = 'writing']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstAbbreviationSection')}" style="visibility: {count(//entry/form[@type = 'abbreviation']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstGrammaticalInformationSection')}" style="visibility: {count(//entry/form[@type = 'grammatical-information']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstLexicalVariant')}" style="visibility: {count(//entry/form[@type = 'lexical-variant-section']) = 0};" />
        {
            ua:get-template("etym-before")
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("etym:first-of-type:before"), "etym-first-of-type-before"),

ua:template("etym-not-first-of-type-before",
    <template>
        {
            ua:get-template("etym-before")
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym:not( :first-of-type):before"), "etym-not-first-of-type-before"),

ua:template("etym-idno-first-of-type",
    <template>
        \00000A Etimologie pentru&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false" style="width: 70px;">
            <option label="" value="" />
            <option label="unul sau mai multe sensuri" value="etymon-type-for-multiple-senses" />
            <option label="una sau mai multe variante lexicale" value="etymon-type-for-multiple-lexical-variants" />
            <option label="cuvântul titlu-element moştenit-etimon atestat" value="cuvântul titlu-element moştenit-etimon atestat" />
            <option label="cuvântul titlu-element moştenit-etimon neatestat" value="cuvântul titlu-element moştenit-etimon neatestat" />
            <option label="cuvântul titlu-element de substrat" value="cuvântul titlu-element de substrat" />
            <option label="cuvântul titlu-formație internă-derivat-cu prefix" value="cuvântul titlu-formație internă-derivat-cu prefix" />
            <option label="cuvântul titlu-formație internă-derivat-cu sufix" value="cuvântul titlu-formație internă-derivat-cu sufix" />
            <option label="cuvântul titlu-formație internă-derivat-cu prefix şi sufix" value="cuvântul titlu-formație internă-derivat-cu prefix şi sufix" />
            <option label="cuvântul titlu-formație internă-compus-element de compunere + cuvânt bază" value="cuvântul titlu-formație internă-compus-element de compunere + cuvânt bază" />
            <option label="cuvântul titlu-formație internă-compus-cuvânt bază + element de compunere" value="cuvântul titlu-formație internă-compus-cuvânt bază + element de compunere" />
            <option label="cuvântul titlu-formație internă-compus-din mai multe cuvinte de bază" value="cuvântul titlu-formație internă-compus-din mai multe cuvinte de bază" />
            <option label="cuvântul titlu-formație internă-compus-formație savantă din latină" value="cuvântul titlu-formație internă-compus-formație savantă din latină" />
            <option label="cuvântul titlu-formație internă-derivat regresiv" value="cuvântul titlu-formație internă-derivat regresiv" />
            <option label="cuvântul titlu-formație internă-derivat postverbal" value="cuvântul titlu-formație internă-derivat postverbal" />
            <option label="cuvântul titlu-formație internă-trimitere-V." value="cuvântul titlu-formație internă-trimitere-V." />
            <option label="cuvântul titlu-formație internă-trimitere-Cf." value="cuvântul titlu-formație internă-trimitere-Cf." />
            <option label="cuvântul titlu-formație internă-trimitere-De la-numele ştiințific al plantei" value="cuvântul titlu-formație internă-trimitere-De la-numele ştiințific al plantei" />
            <option label="cuvântul titlu-formație internă-trimitere-De la-n. pr." value="cuvântul titlu-formație internă-trimitere-De la-n. pr." />
            <option label="cuvântul titlu-formație internă-trimitere-De la-numele de localitate" value="cuvântul titlu-formație internă-trimitere-De la-numele de localitate" />
            <option label="cuvântul titlu-formație internă-trimitere-De la-numele sărbătorii religioase" value="cuvântul titlu-formație internă-trimitere-De la-numele sărbătorii religioase" />
            <option label="cuvântul titlu-formație internă-trimitere-De la-numele ştiințific al planetei" value="cuvântul titlu-formație internă-trimitere-De la-numele ştiințific al planetei" />
            <option label="cuvântul titlu-formație internă-trimitere-Din-etimon atestat" value="cuvântul titlu-formație internă-trimitere-Din-etimon atestat" />
            <option label="cuvântul titlu-formație internă-trimitere-Din-etimon *" value="cuvântul titlu-formație internă-trimitere-Din-etimon *" />
            <option label="cuvântul titlu-formație internă-prescurtare" value="cuvântul titlu-formație internă-prescurtare" />
            <option label="cuvântul titlu-formație internă-contaminare-cu un element-în care primul element este" value="cuvântul titlu-formație internă-contaminare-cu un element-în care primul element este" />
            <option label="cuvântul titlu-formație internă-contaminare-cu un element-în care unul dintre elemente este" value="cuvântul titlu-formație internă-contaminare-cu un element-în care unul dintre elemente este" />
            <option label="cuvântul titlu-formație internă-contaminare-cu două sau mai multe elemente" value="cuvântul titlu-formație internă-contaminare-cu două sau mai multe elemente" />
            <option label="cuvântul titlu-formație internă-calc" value="cuvântul titlu-formație internă-calc" />
            <option label="cuvântul titlu-formație internă-onomatopee" value="cuvântul titlu-formație internă-onomatopee" />
            <option label="cuvântul titlu-formație internă-contragere" value="cuvântul titlu-formație internă-contragere" />
            <option label="cuvântul titlu-formație internă-izolare-prin analiză din împrumuturi ca" value="cuvântul titlu-formație internă-izolare-prin analiză din împrumuturi ca" />
            <option label="cuvântul titlu-formație internă-izolare-prin analiză din cuvinte compuse împrumutate" value="cuvântul titlu-formație internă-izolare-prin analiză din cuvinte compuse împrumutate" />
            <option label="cuvântul titlu-formație internă-izolare-din nume de localităţi" value="cuvântul titlu-formație internă-izolare-din nume de localităţi" />
            <option label="cuvântul titlu-formație internă-singular refăcut după plural" value="cuvântul titlu-formație internă-singular refăcut după plural" />
            <option label="cuvântul titlu-formație internă-formație onomatopeică" value="cuvântul titlu-formație internă-formație onomatopeică" />
            <option label="cuvântul titlu-formație internă-formație spontană de la" value="cuvântul titlu-formație internă-formație spontană de la" />
            <option label="cuvântul titlu-formație internă-prin figură etimologică de la" value="cuvântul titlu-formație internă-prin figură etimologică de la" />
            <option label="cuvântul titlu-formație internă-din formulă de urare" value="cuvântul titlu-formație internă-din formulă de urare" />
            <option label="cuvântul titlu-formație internă-format după" value="cuvântul titlu-formație internă-format după" />
            <option label="cuvântul titlu-formație internă-denumire comercială" value="cuvântul titlu-formație internă-denumire comercială" />
            <option label="cuvântul titlu-element extern-împrumut-etimon sigur" value="cuvântul titlu-element extern-împrumut-etimon sigur" />
            <option label="cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (necunoscut)" value="cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (necunoscut)" />
            <option label="cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (reconstruit) v. sl. *" value="cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (reconstruit) v. sl. *" />
            <option label="cuvântul titlu-element extern-calc" value="cuvântul titlu-element extern-calc" />
            <option label="cuvântul titlu-element extern-trimitere" value="cuvântul titlu-element extern-trimitere" />
            <option label="cuvântul titlu-element necunoscut" value="cuvântul titlu-element necunoscut" />
            <option label="unul sau mai multe sensuri-explicarea sensului-cf. izvor" value="unul sau mai multe sensuri-explicarea sensului-cf. izvor" />
            
            <option label="variantă-directă-prin accidente fonetice-afereză" value="variantă-directă-prin accidente fonetice-afereză" />
            <option label="variantă-directă-prin accidente fonetice-proteză" value="variantă-directă-prin accidente fonetice-proteză" />
            <option label="variantă-directă-prin accidente fonetice-sincopă" value="variantă-directă-prin accidente fonetice-sincopă" />
            <option label="variantă-directă-prin accidente fonetice-epenteză" value="variantă-directă-prin accidente fonetice-epenteză" />
            <option label="variantă-directă-prin accidente fonetice-anaptixă" value="variantă-directă-prin accidente fonetice-anaptixă" />
            <option label="variantă-directă-prin accidente fonetice-apocopă" value="variantă-directă-prin accidente fonetice-apocopă" />
            <option label="variantă-directă-prin accidente fonetice-elidare" value="variantă-directă-prin accidente fonetice-elidare" />
            <option label="variantă-directă-prin accidente fonetice-metateză" value="variantă-directă-prin accidente fonetice-metateză" />
            <option label="variantă-directă-prin accidente fonetice-propagare" value="variantă-directă-prin accidente fonetice-propagare" />
            <option label="variantă-directă-prin accidente fonetice-sinereză" value="variantă-directă-prin accidente fonetice-sinereză" />
            <option label="variantă-directă-cu schimbare de suf." value="variantă-directă-cu schimbare de suf." />
            
            
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno:first-of-type"), "etym-idno-first-of-type"),

ua:template("etymon-type-for-multiple-senses-first-idno",
    <template>
        Pentru&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="explicarea sensului" value="multiple-senses-etymon-subtype-for-explicarea sensului" />
            <option label="sensul" value="multiple-senses-etymon-subtype-for-sensul" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'etymon-type-for-multiple-senses'] + certainty + idno"), "etymon-type-for-multiple-senses-first-idno"),

ua:template("etymon-type-for-multiple-senses-second-idno",
    <template>
        Etimologie sens&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="cf. izvor" value="multiple-senses-etymon-subtype-for-cf. izvor" />
            <option label="cf etimon" value="multiple-senses-etymon-subtype-for-cf etimon" />
            <option label="cf. şi etimon" value="multiple-senses-etymon-subtype-for-cf. şi etimon" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'etymon-type-for-multiple-senses'] + certainty + idno ~ ptr + idno"), "etymon-type-for-multiple-senses-second-idno"),

ua:template("etymon-type-for-multiple-lexical-variants",
    <template>
        Etimologie pentru&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="variantă" value="multiple-lexical-variants-subtype-for-variantă" />
            <option label="variante cu" value="multiple-lexical-variants-subtype-for-variante cu" />
            <option label="variante de tipul" value="multiple-lexical-variants-subtype-for-variante de tipul" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'etymon-type-for-multiple-lexical-variants'] + certainty + idno"), "etymon-type-for-multiple-lexical-variants"),

ua:template("lexical-variant-term",
    <template>
        Variantă lexicală&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'lexical-variant']"), "lexical-variant-term"),

ua:template("lexical-variant-idno",
    <template>
        Tip etimologie&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="directă" value="lexical-variant-subtype-for-directă" />
            <option label="trimitere" value="lexical-variant-subtype-for-trimitere" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'lexical-variant'] + idno"), "lexical-variant-idno"),

ua:template("lexical-variant-subtype-for-directă",
    <template>
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="etimon variantă" value="directă-subtype-for-etimon variantă" />
            <option label="sg. refăcut după plural" value="directă-subtype-for-sg. refăcut după plural" />
            <option label="sg. refăcut după pluralul" value="directă-subtype-for-sg. refăcut după pluralul" />
            <option label="prin apropiere de" value="directă-subtype-for-prin apropiere de" />
            <option label="prin etimologie populară" value="directă-subtype-for-prin etimologie populară" />
            <option label="prin derivare cu sufix" value="directă-subtype-for-prin derivare cu sufix" />
            <option label="sub influenţa" value="directă-subtype-for-sub influenţa" />
            <option label="refăcut după forma articulată" value="directă-subtype-for-refăcut după forma articulată" />
            <option label="refăcut după sg. art." value="directă-subtype-for-refăcut după sg. art." />
            <option label="etimologie populară prin apropiere de" value="directă-subtype-for-etimologie populară prin apropiere de" />
            <option label="din lat." value="directă-subtype-for-din lat." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'lexical-variant-subtype-for-directă'] + idno"), "lexical-variant-subtype-for-directă"),

ua:template("lexical-variant-subtype-for-trimitere",
    <template>
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="cf. cuvânt" value="trimitere-subtype-for-cf. cuvânt" />
            <option label="cf. izvor" value="trimitere-subtype-for-cf. izvor" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'lexical-variant-subtype-for-trimitere'] + idno"), "lexical-variant-subtype-for-trimitere"),

ua:template("directă-subtype-for-etimon variantă",
    <template>
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="atestat" value="etimon variantă-subtype-for-atestat" />
            <option label="reconstruit" value="etimon variantă-subtype-for-reconstruit" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-etimon variantă'] + idno"), "directă-subtype-for-etimon variantă"),

ua:template("etimon variantă-subtype-for-atestat",
    <template>Etimon atestat <input data-ua-ref="{text()}" size="22" />Nr. omonim <input data-ua-ref="{@subtype}" size="3" />Nr. sens <input data-ua-ref="{@type}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'etimon variantă-subtype-for-atestat'] + term"), "etimon variantă-subtype-for-atestat"),

ua:template("singular-dupa-plural", <template>Singular refăcut după plural <input data-ua-ref="{text()}" size="22" /> Nr. omonim <input data-ua-ref="{@subtype}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'singular-dupa-plural']"), "singular-dupa-plural"),

ua:template("formatie-onomatopeica", <template>Formaţie onomatopeică <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'formatie-onomatopeica']"), "formatie-onomatopeica"),

ua:template("formatie-spontana", <template>Formaţie spontană de la <input data-ua-ref="{text()}" size="22" /> Nr. omonim <input data-ua-ref="{@subtype}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'formatie-spontana']"), "formatie-spontana"),

ua:template("figura-etimologica", <template>Prin figură etimologică de la <input data-ua-ref="{text()}" size="22" /> Nr. omonim <input data-ua-ref="{@subtype}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'figura-etimologica']"), "figura-etimologica"),

ua:template("contragere", <template>Contras din <input data-ua-ref="{text()}" size="22" /> Nr. omonim <input data-ua-ref="{@subtype}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'contragere']"), "contragere"),

ua:template("formula-urare", <template>Din formulă de urare <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'formula-urare']"), "formula-urare"),

ua:template("format după", <template><input data-ua-ref="{text()}" size="22" /> Nr. omonim <input data-ua-ref="{@subtype}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'format după']"), "format după"),

ua:template("denumire comercială-term",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'denumire comercială']"), "denumire comercială-term"),

ua:template("latin-base", <template>lat. <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'latin-base']"), "latin-base"),

ua:template("translation", <template>Traducere etimon <input data-ua-ref="{text()}" size="22" /><button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" /></template>),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'translation']"), "translation"),

ua:template("etymon-type-for-multiple-senses-sense-number",
    <template>
        <input data-ua-ref="{text()}" size="5" />
        <button onclick="{oxy:execute-action-by-name('insertSenseNumber')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent; visibility: {count(parent::*/ptr[@type = 'sense-number']) > 1};" />
     </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'etymon-type-for-multiple-senses'] + certainty + idno ~ ptr[type = 'sense-number']"), "etymon-type-for-multiple-senses-sense-number"),

ua:template("multiple-senses-etymon-subtype-for-cf etimon",
    <template>
        Cf. etimon&amp;nbsp;
        <input data-ua-ref="{text()}" size="5" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'multiple-senses-etymon-subtype-for-cf etimon'] ~ ptr"), "multiple-senses-etymon-subtype-for-cf etimon"),

ua:template("multiple-senses-etymon-subtype-for-cf. şi etimon", <template>Cf. şi etimon <input data-ua-ref="{text()}" size="5" /> Nr. omonim <input data-ua-ref="{@subtype}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'multiple-senses-etymon-subtype-for-cf. şi etimon'] ~ ptr"), "multiple-senses-etymon-subtype-for-cf. şi etimon"),

ua:template("etimon variantă-subtype-for-reconstruit", <template>Etimon * <input data-ua-ref="{text()}" size="22" />Nr. omonim <input data-ua-ref="{@subtype}" size="3" />Nr. sens <input data-ua-ref="{@type}" size="3" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'etimon variantă-subtype-for-reconstruit'] + term"), "etimon variantă-subtype-for-reconstruit"),

ua:template("directă-subtype-for-sg. refăcut după pluralul", <template>Sg. refăcut după pluralul <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-sg. refăcut după pluralul'] + term"), "directă-subtype-for-sg. refăcut după pluralul"),

ua:template("directă-subtype-for-prin apropiere de", <template>Prin apropiere de <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-prin apropiere de'] + term"), "directă-subtype-for-prin apropiere de"),

ua:template("directă-subtype-for-prin derivare cu sufix", <template>Prin derivare cu sufix <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-prin derivare cu sufix'] + term"), "directă-subtype-for-prin derivare cu sufix"),

ua:template("directă-subtype-for-sub influenţa", <template>Sub influenţa <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-sub influenţa'] + term"), "directă-subtype-for-sub influenţa"),

ua:template("directă-subtype-for-etimologie populară prin apropiere de", <template>Etimologie populară prin apropiere de <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-etimologie populară prin apropiere de'] + term"), "directă-subtype-for-etimologie populară prin apropiere de"),

ua:template("directă-subtype-for-din lat.", <template>Din lat. <input data-ua-ref="{text()}" size="22" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'directă-subtype-for-din lat.'] + term"), "directă-subtype-for-din lat."),

ua:template("trimitere-subtype-for-cf. cuvânt", <template>Cf. <input data-ua-ref="{text()}" size="5" /></template>),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'trimitere-subtype-for-cf. cuvânt'] + ptr"), "trimitere-subtype-for-cf. cuvânt"),

ua:template("cuvântul titlu-formație internă-izolare-term",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul titlu-formație internă-izolare-'] ~ term"), "cuvântul titlu-formație internă-izolare-term"),
        
ua:template("cuvântul titlu-formație internă-trimitere-V.-template",
    <template>
        V.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-formație internă-trimitere-V.'] ~ ptr"), "cuvântul titlu-formație internă-trimitere-V.-template"),

ua:template("cuvântul titlu-formație internă-trimitere-Cf.-template",
    <template>
        Cf.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-formație internă-trimitere-Cf.'] ~ ptr"), "cuvântul titlu-formație internă-trimitere-Cf.-template"),

ua:template("cuvântul titlu-formație internă-trimitere-De la-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul titlu-formație internă-trimitere-De la-'] ~ term"), "cuvântul titlu-formație internă-trimitere-De la-template"),

ua:template("cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (necunoscut)-term",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        &amp;nbsp;etimon neatestat (necunoscut)&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (necunoscut)'] ~ term"), "cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (necunoscut)-term"),

ua:template("cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (reconstruit) v. sl. *-term",
    <template>
        etimon neatestat (reconstruit) v. sl. *&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (reconstruit) v. sl. *'] ~ term"), "cuvântul titlu-element extern-împrumut-etimon neatestat (reconstruit)-etimon neatestat (reconstruit) v. sl. *-term"),

ua:template("cuvântul titlu-formație internă-trimitere-Din-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        Nr. sens&amp;nbsp;
        <input data-ua-ref="{@type}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul titlu-formație internă-trimitere-Din-'] ~ term"), "cuvântul titlu-formație internă-trimitere-Din-template"),

ua:template("cuvântul titlu-element extern-calc-term",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        &amp;nbsp;Calc după&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-element extern-calc'] ~ term"), "cuvântul titlu-element extern-calc-term"),

ua:template("cuvântul titlu-element necunoscut-term",
    <template>
        Et. nec.
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-element necunoscut'] ~ term"), "cuvântul titlu-element necunoscut-term"),

ua:template("unul sau mai multe sensuri-explicarea sensului-cf. izvor-ptr1",
    <template>
        Număr de sens&amp;nbsp;
        {
            ua:get-template(oxy:get-template("combo",
                map {
                    "edit" := "@target",
                    "editable" := false,
                    "values" := string-join(//sense/@xml:id, ','),
                    "labels" := string-join(//sense/@level, ',')
                }            
            ))
        }
        <button onclick="{oxy:execute-action-by-name('insertSenseNumber')}" style="background-color: transparent;" />        
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'unul sau mai multe sensuri-explicarea sensului-cf. izvor'] + ptr:after"), "unul sau mai multe sensuri-explicarea sensului-cf. izvor-ptr1"),

ua:template("etym-mentioned",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > mentioned"), "etym-mentioned"),

ua:template("cuvântul titlu-element extern-trimitere-mentioned",
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
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-element extern-trimitere'] ~ mentioned"), "cuvântul titlu-element extern-trimitere-mentioned"),

ua:template("etym-certainty",
    <template>
        Probabilitate etimologie&amp;nbsp;
        <select data-ua-ref="{@cert}" contenteditable="false">
            <option label="" value="" />
            <option label="probabil" value="low" />
            <option label="sigur" value="high" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > certainty"), "etym-certainty"),

ua:template("cuvântul titlu-element de substrat-mentioned-etymon",
    <template>
        Cf.&amp;nbsp;
        <select data-ua-ref="{@xml:lang}" contenteditable="false">
            <option label="" value="" />
            <option label="alb." value="alb." />
            <option label="lituan." value="lituan." />
            <option label="v. sl." value="v. sl." />            
        </select>
        {
            ua:get-template("etym-mentioned")
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul titlu-element de substrat'] ~ mentioned"), "cuvântul titlu-element de substrat-mentioned-etymon"),

ua:template("cuvântul titlu-element de substrat-term-etymon",
    <template>
        El. de substrat&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul titlu-element de substrat'] ~ term"), "cuvântul titlu-element de substrat-term-etymon"),

ua:template("cuvântul titlu-element moştenit-etimon atestat-etymon",
    <template>
        Lat.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        În funcţie de partea de vorbire se vor indica următoarele forme ale etimonului: pentru s./ subst. - Nom. şi Gen; pentru adj. - formele de m, f şi n.; pentru vb. - inf. lung ; pentru pron. - formele de Nom., Gen. şi Dat.; pentru num. - formele de m. şi f.; pentru art. - formele de m. şi f.
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul titlu-element moştenit-etimon atestat'] ~ term"), "cuvântul titlu-element moştenit-etimon atestat-etymon"),

ua:template("cuvântul titlu-element moştenit-etimon neatestat-etymon",
    <template>
        Lat. *&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul titlu-element moştenit-etimon neatestat'] ~ term"), "cuvântul titlu-element moştenit-etimon neatestat-etymon"),

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
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $gr-minuscule
                }            
            ))
        }
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
        <button onclick="{oxy:execute-action-by-name('insertBaseWord')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'base']) > 1};" />
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
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'base']) > 2};" />
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

ua:template("regressive-derivate",
    <template>
        Derivat regresiv de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'regressive-derivate']"), "regressive-derivate"),

ua:template("postverbal-derivate",
    <template>
        Derivat postverbal de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'postverbal-derivate']"), "postverbal-derivate"),

ua:template("abbreviation",
    <template>
        Prescurtat de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'abbreviation']"), "abbreviation"),

ua:template("onomatopoeia",
    <template>
        Onomatopee&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        &amp;nbsp;Nr. omonim&amp;nbsp;
        <input data-ua-ref="{@subtype}" size="3" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'onomatopoeia']"), "onomatopoeia"),

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

ua:template("cuvântul titlu-element extern-împrumut-etimon sigur-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        tip etimon sigur&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="cuv. chinezesc" value="cuv. chinezesc" />
            <option label="cuv. japonez" value="cuv. japonez" />
            <option label="cuv. mongol" value="cuv. mongol" />
            <option label="împrumut savant din greacă" value="împrumut savant din greacă" />
        </select>        
        &amp;nbsp;etimon sigur&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "200",
                    "rows" := "55",        
                    "insertChars" := $gr-minuscule
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul titlu-element extern-împrumut-etimon sigur'] ~ term"), "cuvântul titlu-element extern-împrumut-etimon sigur-template"),

ua:template("etym-term-calc",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        &amp;nbsp;Calc după&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'calc']"), "etym-term-calc"),

ua:template("etym-term-added-base",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:execute-action-by-name('insertAddedBase')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'added-base']) > 1};" />        
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'added-base']"), "etym-term-added-base"),

ua:template("xr-syn-before",
    <template>
        Sinonim (cuvânt titlu | nr. ordine omonim | nr. ordine sens)&amp;nbsp;
        <button onclick="{oxy:execute-action-by-name('insertSynonym')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />                
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'syn']:before"), "xr-syn-before"),

ua:template("xr-oRef-before",
    <template>
        <input data-ua-ref="{text()}" size="22" />
        <input data-ua-ref="{@type}" size="2" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr oRef:before"), "xr-oRef-before"),

ua:template("xr-lbl-before",
    <template>
        <input data-ua-ref="{text()}" size="10" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr lbl:before"), "xr-lbl-before"),

ua:template("usg-before",
    <template>
        Indicații privind folosirea:&amp;nbsp;
        <datalist id="usage-options">
            <option label="Ban." value="geo"/>
            <option label="Bas." value="geo"/>
            <option label="Bucov." value="geo"/>
            <option label="Dobr." value="geo"/>
            <option label="Maram." value="geo"/>
            <option label="Mold." value="geo"/>
            <option label="Munt." value="geo"/>
            <option label="Olt." value="geo"/>
            <option label="Transilv." value="geo"/>
            <option label="învechit" value="time"/>
            <option label="ieşit din uz" value="time"/>
            <option label="astăzi rar" value="time"/>
            <option label="Aeron." value="dom"/>
            <option label="Agric." value="dom"/>
            <option label="Agron." value="dom"/>
            <option label="Anat." value="dom"/>
            <option label="Apic." value="dom"/>
            <option label="A. plast." value="dom"/>
            <option label="Arheol." value="dom"/>
            <option label="Arhit." value="dom"/>
            <option label="Astron." value="dom"/>
            <option label="Biol." value="dom"/>
            <option label="Bis." value="dom"/>
            <option label="Bot." value="dom"/>
            <option label="Chim." value="dom"/>
            <option label="Cor." value="dom"/>
            <option label="Cosm." value="dom"/>
            <option label="Culin." value="dom"/>
            <option label="Ec. pol." value="dom"/>
            <option label="Entom." value="dom"/>
            <option label="Farm." value="dom"/>
            <option label="Filoz./Filos." value="dom"/>
            <option label="Fil." value="dom"/>
            <option label="Fin." value="dom"/>
            <option label="Fiz." value="dom"/>
            <option label="Fiziol." value="dom"/>
            <option label="Fon." value="dom"/>
            <option label="Geogr." value="dom"/>
            <option label="Geol." value="dom"/>
            <option label="Geom." value="dom"/>
            <option label="Gram." value="dom"/>
            <option label="Hort." value="dom"/>
            <option label="Iht." value="dom"/>
            <option label="Ind." value="dom"/>
            <option label="Ist." value="dom"/>
            <option label="Jur." value="dom"/>
            <option label="Lingv." value="dom"/>
            <option label="Lit." value="dom"/>
            <option label="Mat." value="dom"/>
            <option label="Med." value="dom"/>
            <option label="Med. vet." value="dom"/>
            <option label="Meteor." value="dom"/>
            <option label="Mil." value="dom"/>
            <option label="Min." value="dom"/>
            <option label="Mitol." value="dom"/>
            <option label="Muz." value="dom"/>
            <option label="Nav." value="dom"/>
            <option label="Numism." value="dom"/>
            <option label="Ornit." value="dom"/>
            <option label="Psih." value="dom"/>
            <option label="Silv." value="dom"/>
            <option label="Şt. nat." value="dom"/>
            <option label="Tehn." value="dom"/>
            <option label="Teol." value="dom"/>
            <option label="Text." value="dom"/>
            <option label="Tipogr." value="dom"/>
            <option label="Top." value="dom"/>
            <option label="Zool." value="dom"/>
            <option label="livresc" value="register"/>
            <option label="popular" value="register"/>
            <option label="regional" value="register"/>
            <option label="familiar" value="register"/>
            <option label="în dicţionarele din trecut" value="register"/>
            <option label="grecism" value="register"/>
            <option label="turcism" value="register"/>
            <option label="franţuzism" value="register"/>
            <option label="englezism" value="register"/>
            <option label="latinism" value="register"/>
            <option label="neobişnuit" value="register"/>
            <option label="argotic" value="register"/>
            <option label="figurat" value="style"/>
            <option label="ironic" value="style"/>
            <option label="depreciativ" value="style"/>
            <option label="glumeţ" value="style"/>
            <option label="emfatic" value="style"/>
            <option label="eufemistic" value="style"/>
            <option label="peiorativ" value="style"/>
            <option label="poetic" value="style"/>
            <option label="ca epitet" value="style"/>
            <option label="rar" value="plev"/>
            <option label="mai ales" value="plev"/>
            <option label="adesea" value="plev"/>
            <option label="în special" value="plev"/>
            <option label="curent" value="plev"/>
            <option label="în dicţionare" value="plev"/>
            <option label="substantivat" value="gram"/>
            <option label="adverbial" value="gram"/>
            <option label="absolut" value="gram"/>
            <option label="la sg." value="gram"/>
            <option label="la pl." value="gram"/>
            <option label="la sg. cu sens de pl." value="gram"/>
            <option label="la sg. cu sens colectiv" value="gram"/>
            <option label="în forma pasivă" value="gram"/>
            <option label="la m." value="gram"/>
            <option label="la f." value="gram"/>
            <option label="la n." value="gram"/>
            <option label="articulat" value="gram"/>
            <option label="la gerunziu" value="gram"/>
        </datalist>
        <input data-ua-ref="{@value}" size="300" list="usage-options" />
        <input data-ua-ref="{text()}" size="22" />      
    </template>
),
ua:attach-template(ua-dt:css-selector("usg:before"), "usg-before"),

ua:template("pc",
    <template>
        <select data-ua-ref="{text()}" contenteditable="false">
            <option label="" value="" />
            <option label="," value="," />
            <option label=";" value=";" />
            <option label="și" value="și" />
            <option label="sau" value="sau" />
        </select>  
    </template>
),
ua:attach-template(ua-dt:css-selector("pc:before"), "pc"),

ua:template("usg-after",
    <template>
        <button onclick="{oxy:execute-action-by-name('insertUsgElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
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
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="ap." value="ap." />
            <option label="cf." value="cf." />
            <option label="în" value="în" />
            <option label="▭" value="▭" />
        </select>    
        <button onclick="{oxy:execute-action-by-name('searchBibliographicReference')}" />
        {concat(ptr/@target, ' ', citedRange/text(), ', datare: ', date/text())}
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl:before"), "bibl-before"),

ua:template("cit-before",
    <template>
        Atestare:
        <button onclick="{oxy:execute-action-by-name('insertCitElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector('cit:before'), "cit-before"),

ua:template("cit-not-first-of-type-before",
    <template>
        {
            ua:get-template('cit-before')
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector('cit:not( :first-of-type):before'), "cit-not-first-of-type-before"),

ua:template("gramGrp-before",
    <template>
        Categorie gramaticală:
        <button onclick="{oxy:execute-action-by-name('addGramGrp')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent; visibility: {local-name(parent::*) = 'sense' or count(parent::*/gramGrp) > 1};" />        
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
            <option label="" value="" />
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
            <option label="(folosit şi absol.)" value="vb.-(folosit şi absol.)" />
            <option label="absol." value="vb.-absol." />
            <option label="fact." value="vb.-fact." />
            <option label="intranz." value="vb.-intranz." />
            <option label="refl." value="vb.-refl." />
            <option label="refl. impers." value="vb.-refl. impers." />
            <option label="refl. pos." value="vb.-refl. pos." />
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
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
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
ua:attach-template(ua-dt:css-selector("form[type = 'graphic-variant'] > orth:before"), "graphic-variant-orth-before"),

ua:template("form-accentuation-before",
    <template>
        Accentuare&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="necunoscută" value="unknown-accentuation" />
            <option label="variantă de accentuare" value="accentuation-variant" />
        </select>
        <button onclick="{oxy:execute-action-by-name('addAccentuationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unknown-accentuation']:before, form[type = 'accentuation-variant']:before"), "form-accentuation-before"),

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
        <button onclick="{oxy:execute-action-by-name('insertUsgElement')}" style="visibility: {count(following-sibling::usg) = 0};" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertBiblElement')}" style="visibility: {count(following-sibling::bibl) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("stress"), "stress"),

ua:template("form-pronunciation-before",
    <template>
        Pronunțare
        <button onclick="{oxy:execute-action-by-name('addPronunciationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
        \00000AIndicaţie de silabaţie
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="bisilabic" value="bisyllabic" />
            <option label="trisilabic" value="trisyllabic" />
        </select>
        <button onclick="{oxy:execute-action-by-name('addFirstSyllabationElement')}" />
        <button onclick="{oxy:execute-action-by-name('addFirstPronElement')}" />
        <button onclick="{oxy:execute-action-by-name('addFirstPVarElement')}" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
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
        <button onclick="{oxy:execute-action-by-name('addSyllabationElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
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
        <button onclick="{oxy:execute-action-by-name('addPronElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > pron"), "form-pronunciation-pron"),

ua:template("form-pronunciation-pVar",
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
        <button onclick="{oxy:execute-action-by-name('addPVarElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > pVar"), "form-pronunciation-pVar"),

ua:template("form-writing-before",
    <template>
        Scriere
        <button onclick="{oxy:execute-action-by-name('addWritingSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) > 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'writing']:before"), "form-writing-before"),

ua:template("form-abbreviation-before",
    <template>
        Abreviere
        <button onclick="{oxy:execute-action-by-name('addAbbreviationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
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
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'abbreviation'] > oVar"), "form-abbreviation-oVar"),

ua:template("form-grammatical-information-idno-first-of-type",
    <template>
        Indicații pentru&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
            <option label="adj. / pron. / num. / s. / subst." value="grammatical-information-type-for-adj-et-al" />
            <option label="vb." value="grammatical-information-type-for-vb" />
        </select>   
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information'] > idno:first-of-type"), "form-grammatical-information-idno-first-of-type"),

ua:template("form-grammatical-information-idno-nth-of-type-2",
    <template>
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="" value="" />
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
        <button onclick="{oxy:execute-action-by-name('addGenElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural'] > gen:after"), "form-grammatical-information-for-plural-gen-after"),

ua:template("form-grammatical-information-for-gender-gen-before",
    <template>
        Gen&amp;nbsp;
        <select data-ua-ref="{@target}" contenteditable="false">
            <option label="" value="" />
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
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
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
        <button onclick="{oxy:execute-action-by-name('addLexicalVariant')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstSenseNumber')}" style="visibility: {count(ptr) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstAccentuationSection')}" style="visibility: {count(form[contains(' unknown-accentuation accentuation-variant ', @type)]) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstPronunciationSection')}" style="visibility: {count(form[@type = 'pronunciation']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstWritingSection')}" style="visibility: {count(form[@type = 'writing']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstAbbreviationSection')}" style="visibility: {count(form[@type = 'abbreviation']) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstGrammaticalInformationSection')}" style="visibility: {count(form[@type = 'grammatical-information']) = 0};" />
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
                    "labels" := string-join(//sense/@level, ',')
                }            
            ))
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
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
                    "labels" := string-join(//sense/@level, ',')
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
                    "labels" := string-join(//sense/@level, ',')
                }            
            ))
        }
        <button onclick="{oxy:execute-action-by-name('insertSenseNumber')}" style="background-color: transparent;" />        
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'lexical-variant-section'] > ptr:after"), "form-lexical-variant-section-ptr-after"),

ua:template("graphic-variant-not-first-of-type-before",
    <template>
        {
            ua:get-template('graphic-variant-before')
        }    
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'graphic-variant']:not( :first-of-type):before"), "graphic-variant-not-first-of-type-before"),


ua:template("form-grammatical-information-for-plural-before",
    <template>
        \00000AIndicaţii pentru plural
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationForPluralSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:execute-action-by-name('addFirstGenElement')}" style="visibility: {count(gen) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstSenseNumber')}" style="visibility: {count(ptr) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false"/>
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural']:before"), "form-grammatical-information-for-plural-before"),

ua:template("form-grammatical-information-for-plural-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-plural-before')
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural']:not( :first-of-type):before "), "form-grammatical-information-for-plural-not-first-of-type-before"),

ua:template("form-grammatical-information-for-case-before",
    <template>
        \00000AIndicaţii pentru caz
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationForCaseSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstSenseNumber')}" style="visibility: {count(ptr) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false"/>         
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-case']:before"), "form-grammatical-information-for-case-before"),

ua:template("form-grammatical-information-for-case-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-case-before')
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />       
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
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />       
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-gender']:not( :first-of-type):before"), "form-grammatical-information-for-gender-not-first-of-type-before"),

ua:template("form-grammatical-information-for-verb-before",
    <template>
        \00000AIndicaţii pentru verb
        <button onclick="{oxy:execute-action-by-name('addGrammaticalInformationForVerbSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('insertFirstStressElement')}" style="visibility: {count(stress) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstUsgElement')}" style="visibility: {count(usg) = 0};" />
        <button onclick="{oxy:execute-action-by-name('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" data-showIcon="false"/>
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb']:before"), "form-grammatical-information-for-verb-before"),

ua:template("form-grammatical-information-for-verb-not-first-of-type-before",
    <template>
        {
            ua:get-template('form-grammatical-information-for-verb-before')
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb']:not( :first-of-type):before"), "form-grammatical-information-for-verb-not-first-of-type-before"),

ua:template("sense-currentEdited-value-before",
    <template>
        Nivel:&amp;nbsp;
        <select data-ua-ref="{@level}" contenteditable="true" style="width: 17px;">
            <option label="◊" value="◊" />
            <option label="♦" value="♦" />
        </select>
        <button onclick="{oxy:execute-action-by-name('addGramGrp')}" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertReference')}" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("sense:before"), "sense-currentEdited-value-before"),


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

ua:template("idno-proces-semantic",
    <template>
        Procese semantice:&amp;nbsp;
        {
            $semantical-process-template
        } 
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[n = 'tip-proces-semantic']"), "idno-proces-semantic"),

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
        <button onclick="{oxy:execute-action-by-name('insertAuthorElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("author:before"), "author-before"),

ua:template("author-not-first-of-type-before",
    <template>
        {
            ua:get-template('author-before')
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("author:not( :first-of-type):before"), "author-not-first-of-type-before"), 

ua:template("editor-before",
    <template>
        Revizor*:&amp;nbsp;
        <select data-ua-ref="{text()}" contenteditable="false">
            <option label="guest" value="guest" />
        </select>
        <button onclick="{oxy:execute-action-by-name('insertEditorElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("editor:before"), "editor-before"),

ua:template("editor-not-first-of-type-before",
    <template>
        {
            ua:get-template('editor-before')
        }
        <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("editor:not( :first-of-type):before"), "editor-not-first-of-type-before"), 

ua:template("creation",
    <template>
        Creat:&amp;nbsp;
    </template>
),
ua:attach-template(ua-dt:css-selector("creation"), "creation"),

ua:template("creation-date",
    <template>
        {concat(substring(@when, 1, 22), ':', substring(@when, 23))}
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

ua:template("entry-form-main-after",
    <template>
        {
            ua:get-template(oxy:get-template("ro.dlri.oxygen.templates.tree.TreeFormControl",
                map {
                    "edit" := "#text",
                    "width" := "1100",
                    "height" := "350",
                    "itemLabel" := "concat(@level, ' ', if (form) then concat(form, ' =') else (), ' ', string-join(def, ' '))"
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > form[type = 'main']:after"), "entry-form-main-after"),

ua:template("syll",
    <template>
        Despărțire în silabe:&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("syll"), "syll"),

ua:template("def",
    <template>
        Nivel&amp;nbsp;
        <input data-ua-ref="{@n}" size="7" />
        <button onclick="{oxy:execute-action-by-name('insertUsgElement')}" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertSynonym')}" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertAnalogy')}" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertAssociation')}" data-showIcon="false" />
        <button onclick="{oxy:execute-action-by-name('insertAntonym')}" data-showIcon="false" />
        \00000A
        <textarea data-ua-ref="{text()}" cols="70" rows="7" data-contentType="text/plain" />
        <button onclick="{oxy:execute-action-by-name('insertDefElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:execute-action-by-name('deleteDefElement')}" style="background-color: transparent; visibility: {count(parent::*/def) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("def"), "def"),

ua:template("rich-textarea-dialog",
    <template>
        <dialog style="width: 600px; height: 320px;" title="Introducere date pentru conexiunea la server" data-ua-type="modal">
            <table>
                <tr>
                    <td>Nume de utilizator</td>
                    <td>
                        <input />
                    </td>
                </tr>
                <tr>
                    <td>Parola</td>
                    <td>
                        <input type="password" />
                    </td>
                </tr>
            </table>
            <textarea cols="70" rows="10">Lorem ipsum dolor sit amet,....</textarea>
            <button data-ua-ref="" onclick="OxygenAddonBuilder.closeDialogWindow();">Close</button>
        </dialog>
    </template>
),
ua:attach-template(ua-dt:css-selector("entry:before"), "rich-textarea-dialog"),

ua:template("entry-form-main-before",
    <template>
        Cuvânt titlu*:&amp;nbsp;
        {
            ua:get-template(oxy:get-template("ro.kuberam.oxygen.addonBuilder.templates.java.richTextArea.RichTextAreaFormControl",
                map {
                    "edit" := "#text",
                    "cols" := "700",
                    "rows" := "55",        
                    "insertChars" := $ro-vocale-majuscule
                }            
            ))
        }
        \00000ANumăr ordine omonime:&amp;nbsp;
        <input data-ua-ref="{@n}" size="2" />
        <button onclick="{ua:show-template('rich-textarea-dialog')}">Show HTML2JavaFX dialog</button>        
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > form[type = 'main'] > orth:before"), "entry-form-main-before"),

ua:template("sense-form-before",
    <template>
        <input data-ua-ref="{text()}" size="108" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > form:before"), "sense-form-before")
