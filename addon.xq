xquery version "3.0";

import module "http://expath.org/ns/user-agent/";

declare namespace ua-dt = "http://expath.org/ns/user-agent/datatype/";
declare namespace oxy = "http://oxygenxml.com/extensions/author/";

declare variable $ua:document := /;

declare variable $languages-template as element() :=
	<select data-ua-ref="{@xml:lang}" contenteditable="false">
	    <option xml:id="id" label="" value="" />
	    <option xml:id="sq" label="alb." value="sq" />
	    <option xml:id="rup" label="ar." value="rup" />
	    <option xml:id="bg" label="bg." value="bg" />
	    <option xml:id="ca" label="cat." value="ca" />
	    <option xml:id="cs" label="ceh." value="cs" />
	    <option xml:id="cs" label="ceh." value="cs" />
	    <option xml:id="dlm" label="dalm." value="dlm" />
	    <option xml:id="he" label="ebr." value="he" />
	    <option xml:id="rm-puter-vallader" label="engad." value="rm-puter-vallader" />
	    <option xml:id="en" label="engl." value="en" />
	    <option xml:id="eo" label="esper." value="eo" />
	    <option xml:id="fr" label="fr." value="fr" />
	    <option xml:id="fur" label="friul." value="fur" />
	    <option xml:id="de" label="germ." value="de" />
	    <option xml:id="grc" label="gr." value="grc" />
	    <option xml:id="ruo" label="ir." value="ruo" />
	    <option xml:id="it" label="it." value="it" />
	    <option xml:id="la" label="lat." value="la" />
	    <option xml:id="la-x-popular" label="lat. pop." value="la-x-popular" />
	    <option xml:id="la-x-medieval" label="lat. mediev." value="la-x-medieval" />
	    <option xml:id="lt" label="lituan." value="lt" />
	    <option xml:id="hu" label="magh." value="hu" />
	    <option xml:id="ruq" label="mr." value="ruq" />
	    <option xml:id="gre" label="gr. bizant." value="gre" />
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

declare variable $target-languages-template as element() :=
	<select data-ua-ref="{@targetLang}" contenteditable="false">
	    <option xml:id="id" label="" value="" />
	    <option xml:id="sq" label="alb." value="sq" />
	    <option xml:id="rup" label="ar." value="rup" />
	    <option xml:id="bg" label="bg." value="bg" />
	    <option xml:id="ca" label="cat." value="ca" />
	    <option xml:id="cs" label="ceh." value="cs" />
	    <option xml:id="cs" label="ceh." value="cs" />
	    <option xml:id="dlm" label="dalm." value="dlm" />
	    <option xml:id="he" label="ebr." value="he" />
	    <option xml:id="rm-puter-vallader" label="engad." value="rm-puter-vallader" />
	    <option xml:id="en" label="engl." value="en" />
	    <option xml:id="eo" label="esper." value="eo" />
	    <option xml:id="fr" label="fr." value="fr" />
	    <option xml:id="fur" label="friul." value="fur" />
	    <option xml:id="de" label="germ." value="de" />
	    <option xml:id="grc" label="gr." value="grc" />
	    <option xml:id="ruo" label="ir." value="ruo" />
	    <option xml:id="it" label="it." value="it" />
	    <option xml:id="la" label="lat." value="la" />
	    <option xml:id="la-x-popular" label="lat. pop." value="la-x-popular" />
	    <option xml:id="la-x-medieval" label="lat. mediev." value="la-x-medieval" />
	    <option xml:id="lt" label="lituan." value="lt" />
	    <option xml:id="hu" label="magh." value="hu" />
	    <option xml:id="ruq" label="mr." value="ruq" />
	    <option xml:id="gre" label="gr. bizant." value="gre" />
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

ua:action(
    "insertFirstBiblElement",
    map { 
        "name" := "Izvor"       
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertFirstBiblElement.xq")   
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
    "searchBibliographicReferenceAuthors",
    map { 
        "name" := "Căutare"       
    },   
    oxy:execute-xquery-script("resources/xquery/get-bibliographic-reference-authors.xql")
),
ua:action(
    "insertBibliographicReferenceAuthor",
    map { 
        "name" := "Autor"       
    },
    oxy:execute-xquery-update-script("resources/xquery/insertBibliographicReferenceAuthor.xql")
),
ua:action(
    "addFirstAccentuationSection",
    map { 
        "name" := "Accentuare"        
    },
	oxy:execute-xquery-update-script("resources/xquery/addFirstAccentuationSection.xq")    
),
ua:action(
    "addFirstPronunciationSection",
    map { 
        "name" := "Pronunțare"       
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstPronunciationSection.xq")
),
ua:action(
    "addFirstGrammaticalInformationSection",
    map { 
        "name" := "Indicații gramaticale"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstGrammaticalInformationSection.xq")
),
ua:action(
    "addFirstWritingSection",
    map { 
        "name" := "Scriere"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstWritingSection.xq")
),
ua:action(
    "addFirstAbbreviationSection",
    map { 
        "name" := "Abreviere"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addFirstAbbreviationSection.xql")
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
    "cloneCurrentElement",
    map { 
        "name" := "Duplicare",
        "smallIconPath" := "../../resources/images/clone.png"       
    },   
    oxy:execute-xquery-update-script("resources/xquery/cloneCurrentElement.xql")
),
ua:action(
    "deleteSenseElement",
    map { 
        "name" := "Ștergere",
        "smallIconPath" := "${framework}/resources/images/delete.png"       
    },   
    oxy:execute-xquery-update-script("actions/deleteCurrentElement.xq")
),
ua:action(
    "insertUsgElement",
    map { 
        "name" := "Indicație folosire",
        "smallIconPath" := "../../resources/images/add.png"        
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertUsgElement.xql")  
),
ua:action(
    "insertBiblElement",
    map { 
        "name" := "Izvor",
        "smallIconPath" := "../../resources/images/add.png"       
    },
    oxy:execute-xquery-update-script("resources/xquery/insertBiblElement.xq")    
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
    "addGramGrp",
    map { 
        "name" := "Cat. gram.",
        "smallIconPath" := "../../resources/images/add.png"        
    },
    oxy:execute-xquery-update-script("resources/xquery/addGramGrp.xq")
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
    "insertBaseWord",
    map { 
        "name" := "insertBaseWord",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertBaseWord.xq") 
),
ua:action(
    "insertPtrElement",
    map { 
        "name" := "insertPtrElement",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertPtrElement.xq") 
),
ua:action(
    "insertComponentElement",
    map { 
        "name" := "insertComponentElement",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertComponentElement.xq") 
),
ua:action(
    "editEtymologicalNote",
    map { 
        "name" := "Editează notă",
        "smallIconPath" := "${framework}/resources/images/edit.png"
    },   
    oxy:execute-action-by-class("ro.kuberam.oxygen.addonBuilder.operations.EditDocumentFragmentInNewTabOperation")
),
ua:action(
    "changedValueAttrOfFormElement",
    map { 
        "name" := "changedValueAttrOfFormElement"
    },
    oxy:execute-xquery-update-script("actions/changed-value-attr-of-form-element.xql")
),
ua:action(
    "changedValueAttrOfPosElement",
    map { 
        "name" := "changedValueAttrOfPosElement"
    },
    oxy:execute-xquery-update-script("actions/changed-value-attr-of-pos-element.xql")
),
ua:action(
    "changedTypeAttrOfIdnoElement",
    map { 
        "name" := "changedTypeAttrOfIdnoElement"
    },
    oxy:execute-xquery-update-script("actions/changed-type-attr-of-idno-element.xql")
),
ua:action(
    "changedValueAttrOfUsgElement",
    map { 
        "name" := "changedValueAttrOfUsgElement"
    },
    oxy:execute-xquery-update-script("actions/changed-value-attr-of-usg-element.xql")
),
ua:action(
    "changedTypeAttrOfNoteElement",
    map { 
        "name" := "changedTypeAttrOfNoteElement"
    },
	oxy:execute-xquery-update-script("actions/changed-type-attr-of-note-element.xql")
),
ua:action(
    "changedTargetLangAttrOfPtrElement",
    map { 
        "name" := "changedTargetLangAttrOfPtrElement"
    },
	oxy:execute-xquery-update-script("actions/changed-targetLang-attr-of-ptr-element.xql")
),
ua:action(
    "changedLangAttrOfTermElement",
    map { 
        "name" := "changedLangAttrOfTermElement"
    },
	oxy:execute-xquery-update-script("actions/changed-lang-attr-of-term-element.xql")
),
ua:action(
    "insertSenseElementAsFirstChild",
    map { 
        "name" := "insertSenseElementAsFirstChild"
    },
    oxy:execute-xquery-update-script("actions/insertSenseElementAsFirstChild.xq")
),
ua:action(
    "insertSenseElementAsFollowingSibling",
    map { 
        "name" := "insertSenseElementAsFollowingSibling"
    },
    oxy:execute-xquery-update-script("actions/insertSenseElementAsFollowingSibling.xq")
),
ua:observer("changedTypeAttrOfIdnoElementObserver", "changedTypeAttrOfIdnoElement"),
ua:connect-observer("changedTypeAttrOfIdnoElementObserver", ua-dt:xpath-selector('//idno'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['type']"}
),
ua:observer("changedValueAttrOfPosElementObserver", "changedValueAttrOfPosElement"),
ua:connect-observer("changedValueAttrOfPosElementObserver", ua-dt:xpath-selector('//pos'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['value']"}
),
ua:observer("changedValueAttrOfFormElementObserver", "changedValueAttrOfFormElement"),
ua:connect-observer("changedValueAttrOfFormElementObserver", ua-dt:xpath-selector('//form'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['type']"}
),
ua:observer("changedValueAttrOfUsgElementObserver", "changedValueAttrOfUsgElement"),
ua:connect-observer("changedValueAttrOfUsgElementObserver", ua-dt:xpath-selector('//usg'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['value']"}
),
ua:observer("changedTypeAttrOfNoteElementObserver", "changedTypeAttrOfNoteElement"),
ua:connect-observer("changedTypeAttrOfNoteElementObserver", ua-dt:xpath-selector('//note'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['type']"}
),
ua:observer("changedTargetLangAttrOfPtrElementObserver", "changedTargetLangAttrOfPtrElement"),
ua:connect-observer("changedTargetLangAttrOfPtrElementObserver", ua-dt:xpath-selector('//ptr'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['targetLang']"}
),
ua:observer("changedLangAttrOfTermElementObserver", "changedLangAttrOfTermElement"),
ua:connect-observer("changedLangAttrOfTermElementObserver", ua-dt:xpath-selector('//term'),
    map {
        "attributes" := "true",
        "attributeFilter" := "['xml:lang']"}
),
ua:add-event-listener($ua:document, "load", oxy:execute-action-by-class('ro.kuberam.oxygen.addonBuilder.actions.KeepAuthorView')),

ua:template("TEI-before-template",
    <template>
        <button onclick="{oxy:xquery-update-action('addFirstAccentuationSection')}" style="visibility: {count(//entry/form[contains(' unknown-accentuation accentuation-variant ', @type)]) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstArticulationSection.xq')}" style="visibility: {count(//entry/form[@type = 'articulation']) = 0}; background-color: transparent; color: blue;">Articulare</button>
        <button onclick="{oxy:xquery-update-action('addFirstPronunciationSection')}" style="visibility: {count(//entry/form[@type = 'pronunciation']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstWritingSection')}" style="visibility: {count(//entry/form[@type = 'writing']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstAbbreviationSection')}" style="visibility: {count(//entry/form[@type = 'abbreviation']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update-action('addFirstGrammaticalInformationSection')}" style="visibility: {count(//entry/form[@type = 'grammatical-information']) = 0}; background-color: transparent; color: blue;" />
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstLexicalVariant.xql')}" style="visibility: {count(//entry/re[@type = 'lexical-variant-section']) = 0}; background-color: transparent; color: blue;">Variantă lexicală</button>
    </template>
),
ua:attach-template(ua-dt:css-selector("TEI:before"), "TEI-before-template"),

ua:template("editing-mode-template",
    <template>
    	Mod editare&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false">
            <option label="dlr" value="editing-mode-dlr" />
            <option label="dex" value="editing-mode-dex" />            
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("text:before"), "editing-mode-template"),


ua:template("grammatical-information-form",
    <template>
        Indicații gramaticale
        <button onclick="{oxy:xquery-update-action('addGrammaticalInformationSection')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('cloneCurrentElement')}" style="background-color: transparent;" />
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
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsFirstIntoElement.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>                
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
        <button onclick="{oxy:xquery-update('resources/xquery/addEtymElementAfter.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        Probabilitate etimologie&amp;nbsp;
        <input data-ua-ref="{@cert}" type="radio" value="high">sigur</input>
        <input data-ua-ref="{@cert}" type="radio" value="low">probabil</input>      
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {idno[1]/@type = 'cuvântul.titlu-element.de.substrat' and count(bibl) = 0};" />
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" data-showIcon="false" style="visibility: {idno[starts-with(@type, 'cuvântul.titlu-formație.internă-trimitere-')] and count(gramGrp) = 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/addEtymonTranslation.xq')}" style="visibility: {idno[1][starts-with(@type, 'variantă-directă-etimon.variantă')] and count(term[@type = 'translation']) = 0};">Traducere etimon</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstEtymologicalNote.xq')}" style="visibility: {count(note) = 0};">Notă</button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(//entry/etym) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym:before"), "etym-before"),

ua:template("entry-etym-idno-first-of-type",
    <template>
        \00000A Etimologie pentru&amp;nbsp;
        <datalist id="headword-etymology-types" />
        <input data-ua-ref="{@type}" size="80" list="headword-etymology-types" />               
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > etym > idno:first-of-type"), "entry-etym-idno-first-of-type"),

ua:template("sense-etym-idno-first-of-type",
    <template>
        \00000A Etimologie pentru&amp;nbsp;
        <datalist id="sense-etymology-types" />
        <input data-ua-ref="{@type}" size="80" list="sense-etymology-types" />               
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > etym > idno:first-of-type"), "sense-etym-idno-first-of-type"),

ua:template("variant-etym-idno-first-of-type",
    <template>
        \00000A Etimologie pentru&amp;nbsp;
        <datalist id="variant-etymology-types" />
        <input data-ua-ref="{@type}" size="80" list="variant-etymology-types" />               
    </template>
),
ua:attach-template(ua-dt:css-selector("re[type = 'lexical-variant-section'] > etym > idno:first-of-type"), "variant-etym-idno-first-of-type"),

ua:template("cuvântul.titlu-formație.internă-formație.onomatopeică-template",
    <template>
        Formaţie onomatopeică&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-formație.onomatopeică'] ~ term"), "cuvântul.titlu-formație.internă-formație.onomatopeică-template"),

ua:template("cuvântul.titlu-formație.internă-din.formulă.de.urare-template",
    <template>
        Din formulă de urare&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-din.formulă.de.urare'] ~ term"), "cuvântul.titlu-formație.internă-din.formulă.de.urare-template"),

ua:template("translation-template",
	<template>
		Traducere etimon&amp;nbsp;
		<input data-ua-ref="{text()}" size="22" />
		<button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
	</template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'translation']"), "translation-template"),

ua:template("variantă-directă-din.lat.-template",
    <template>
        Din lat.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-din.lat.'] ~ term"), "variantă-directă-din.lat.-template")
,
ua:template("una.sau.mai.multe.variante.lexicale-term-template",
    <template>
        Pentru&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/insert-una.sau.mai.multe.variante.lexicale-term-template.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/term[@type = 'una.sau.mai.multe.variante.lexicale']) > 1}" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'una.sau.mai.multe.variante.lexicale']"), "una.sau.mai.multe.variante.lexicale-term-template")
,
ua:template("una.sau.mai.multe.variante.lexicale-*-trimitere-cf..cuvânt-term-template",
    <template>
        cf.&amp;nbsp;
        {
            $languages-template
        }        
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/insert-una.sau.mai.multe.variante.lexicale-cf.-term-template.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/(term | ptr)[@type = 'una.sau.mai.multe.variante.lexicale-cf.']) > 1}" />        
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'una.sau.mai.multe.variante.lexicale-cf.']"), "una.sau.mai.multe.variante.lexicale-*-trimitere-cf..cuvânt-term-template")
,
ua:template("cuvântul.titlu-etimon.neatestat.(reconstruit)-term",
    <template>
        Limba&amp;nbsp;
        <select data-ua-ref="{@xml:lang}" contenteditable="false">
            <option label="" value="unknown" />
            <option label="lat*" value="la" />
            <option label="v. sl." value="v. sl." />            
        </select>
        etimon neatestat (necunoscut)&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-etimon.neatestat.(reconstruit)'] ~ term"), "cuvântul.titlu-etimon.neatestat.(reconstruit)-term"),

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

ua:template("cuvântul.titlu-element.extern-trimitere-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'cuvântul.titlu-element.extern-trimitere'] ~ term"), "cuvântul.titlu-element.extern-trimitere-template"),

ua:template("cuvântul.titlu-element.de.substrat-term-1-etymon",
    <template>
        El. de substrat&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-element.de.substrat'] ~ term:nth-of-type(1):before"), "cuvântul.titlu-element.de.substrat-term-1-etymon"),

ua:template("cuvântul.titlu-element.de.substrat-term-2-template",
    <template>
        Cf.&amp;nbsp;
        <select data-ua-ref="{@xml:lang}" contenteditable="false">
            <option label="" value="" />
            <option label="alb." value="sq" />
            <option label="lituan." value="lt" />
            <option label="v. sl." value="v. sl." />            
        </select>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-element.de.substrat'] ~ term:nth-of-type(2):before"), "cuvântul.titlu-element.de.substrat-term-2-template"),

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

ua:template("etym-term-prefix-template",
    <template>
        Prefix&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'prefix']"), "etym-term-prefix-template"),

ua:template("etym-term-sufix-template",
    <template>
        Sufix&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'sufix']"), "etym-term-sufix-template")
,
ua:template("ptr-template",
    <template>
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr:after"), "ptr-template")
,
ua:template("una.sau.mai.multe.variante.lexicale-*-trimitere-cf..cuvânt-ptr-template",
    <template>
        cf.&amp;nbsp;
        {
            $target-languages-template
        }
        {
            ua:get-template('ptr-template')
        }        
        <button onclick="{oxy:xquery-update('resources/xquery/insert-una.sau.mai.multe.variante.lexicale-cf.-ptr-template.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/(term | ptr)[@type = 'una.sau.mai.multe.variante.lexicale-cf.']) > 1}" />        
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'una.sau.mai.multe.variante.lexicale-cf.']:after"), "una.sau.mai.multe.variante.lexicale-*-trimitere-cf..cuvânt-ptr-template")
,
ua:template("unul.sau.mai.multe.sensuri-sensul-*-ptr-template",
    <template>
    	Număr de sens&amp;nbsp;
        {
            ua:get-template('ptr-template')
        }
        <button onclick="{oxy:xquery-update('resources/xquery/insert-unul.sau.mai.multe.sensuri-sensul-ptr-template.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/ptr[@type = 'unul.sau.mai.multe.sensuri-sensul']) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'unul.sau.mai.multe.sensuri-sensul']:after"), "unul.sau.mai.multe.sensuri-sensul-*-ptr-template")
,
ua:template("unul.sau.mai.multe.sensuri-sensul-cf.-ptr-template",
    <template>
    	Cf.&amp;nbsp;
        {
            $target-languages-template
        }
        {
            ua:get-template('ptr-template')
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'unul.sau.mai.multe.sensuri-sensul-cf.']:after"), "unul.sau.mai.multe.sensuri-sensul-cf.-ptr-template")
,
ua:template("cuvântul.titlu-formație.internă-compus-format.din-bază-ptr-template",
    <template>
        Limba&amp;nbsp;
        {
            $target-languages-template
        }
        {
            ua:get-template('ptr-template')
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'cuvântul.titlu-formație.internă-compus-format.din-bază']:after"), "cuvântul.titlu-formație.internă-compus-format.din-bază-ptr-template")
,
ua:template("cuvântul.titlu-formație.internă-compus-format.din-bază-term-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'cuvântul.titlu-formație.internă-compus-format.din-bază']:after"), "cuvântul.titlu-formație.internă-compus-format.din-bază-term-template")
,
ua:template("cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-ptr-template",
    <template>
        Limba&amp;nbsp;
        {
            $target-languages-template
        }
        {
            ua:get-template('ptr-template')
        }
        <button onclick="{oxy:xquery-update('resources/xquery/insert-cuvântul.titlu-formație.internă-compus-format.din-element.adăugat.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/(term | ptr)[@type = 'cuvântul.titlu-formație.internă-compus-format.din-element.adăugat']) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'cuvântul.titlu-formație.internă-compus-format.din-element.adăugat']:after"), "cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-ptr-template")
,
ua:template("cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-term-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/insert-cuvântul.titlu-formație.internă-compus-format.din-element.adăugat.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/(term | ptr)[@type = 'cuvântul.titlu-formație.internă-compus-format.din-element.adăugat']) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'cuvântul.titlu-formație.internă-compus-format.din-element.adăugat']:after"), "cuvântul.titlu-formație.internă-compus-format.din-element.adăugat-term-template")
,
ua:template("ptr-base-word-template",
    <template>
        Cuvânt de bază&amp;nbsp;
        {
            ua:get-template('ptr-template')
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'base-word']:after"), "ptr-base-word-template")
,
ua:template("cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază-template",
    <template>
    	Cuvânt de bază&amp;nbsp;
        {
            ua:get-template('ptr-template')
        }
        <button onclick="{oxy:xquery-update-action('insertBaseWord')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/ptr) > 2};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[type = 'cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază'] ~ ptr:after"), "cuvântul.titlu-formație.internă-compus-din.mai.multe.cuvinte.de.bază-template")
,
ua:template("latin-base-template",
    <template>
        lat.
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("term[type = 'latin-base']:after"), "latin-base-template"),

ua:template("added-base-template",
    <template>
        +&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("ptr[type = 'added-base']"), "added-base-template"),

ua:template("ptr-component-element-template",
    <template>
        Element de compunere&amp;nbsp;
        {
            ua:get-template('ptr-template')
        }
        <button onclick="{oxy:xquery-update-action('insertComponentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/ptr[@type = 'component-element']) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'component-element']:after"), "ptr-component-element-template"),

ua:template("variantă-directă-derivat.regresiv.de.la-template",
    <template>
        Derivat regresiv de la&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'variantă-directă-derivat.regresiv.de.la'] ~ term"), "variantă-directă-derivat.regresiv.de.la-template")
,
ua:template("cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente-ptr1-template",
    <template>
        Contaminare între&amp;nbsp;
        {
            ua:get-template('ptr-template')
        }
        \00000Aşi&amp;nbsp;
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente'] ~ ptr:nth-of-type(1):after"), "cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente-ptr1-template"),

ua:template("cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente-ptr2-template",
    <template>
        {
            ua:get-template('ptr-template')
        }
        <button onclick="{oxy:xquery-update-action('insertPtrElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/ptr) > 2};" />        
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente'] ~ ptr:not( :first-of-type):after"), "cuvântul.titlu-formație.internă-contaminare-cu.două.sau.mai.multe.elemente-ptr2-template"),

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

ua:template("cuvântul.titlu-formație.internă-trimitere-Cf.-ptr-template",
    <template>
        Limba&amp;nbsp;
        {
            $target-languages-template
        }
        {
            ua:get-template('ptr-template')
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > ptr[type = 'cuvântul.titlu-formație.internă-trimitere-Cf.']:after"), "cuvântul.titlu-formație.internă-trimitere-Cf.-ptr-template")
,
ua:template("cuvântul.titlu-formație.internă-trimitere-Cf.-term-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > term[type = 'cuvântul.titlu-formație.internă-trimitere-Cf.']:after"), "cuvântul.titlu-formație.internă-trimitere-Cf.-term-template")
,
ua:template("etym-note-template",
    <template>
		Notă&amp;nbsp;
		<button onclick="{oxy:xquery-update('resources/xquery/addEtymologicalNote.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
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
			<option label="înv." value="time"/>
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
			<option label="Electron." value="dom"/>
			<option label="Electrotehn." value="dom"/>
			<option label="Entom." value="dom"/>
			<option label="Farm." value="dom"/>
			<option label="Farmac." value="dom"/>
			<option label="Farmacol." value="dom"/>
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
			<option label="Relig." value="dom"/>
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
			<option label="Sociol." value="dom"/>
			<option label="Zool." value="dom"/>
			<option label="Chirurg." value="dom"/>
			<option label="Geomorf." value="dom"/>
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
			<option label="glumeț" value="register style"/>
			<option label="în.argoul" value="register style"/>
			<option label="în.basme" value="register style"/>
			<option label="în.basme.și.superstiții" value="register style"/>
			<option label="în.cântece.de.leagăn" value="register style"/>
			<option label="în.colinde" value="register style"/>
			<option label="în.jurăminte" value="register style"/>
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
			<option label="absol." value="gram"/>
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
			<option label="și.substantivat" value="gram"/>
			<option label="complementul.indică" value="obj"/>
			<option label="cu.complement.intern" value="obj"/>
			<option label="cu.subiectul.....sau.un.echivalent.al.acestuia" value="subj"/>
			<option label="cu.subiectul.neexprimat,.subînțelegându-se" value="subj"/>
			<option label="cu.subiectul.personificat" value="subj"/>
			<option label="cu.subiectul.personificat" value="subj"/>
			<option label="cu.subiectul.exprimat.sau.subînțeles" value="subj"/>
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
			<option label="prin.metonimie" value="hint"/>
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
			<option label="într-o.ghicitoare" value="coloc"/>
			<option label="indică" value="coloc"/>
			<option label="întărit.prin" value="coloc"/>
			<option label="precedă" value="coloc"/>
			<option label="precedă.noțiuni.temporale" value="coloc"/>
			<option label="precedă.ultimul.termen.al.unei.enumerări" value="coloc"/>
			<option label="precedat.de" value="coloc"/>
			<option label="precedat.de.prep." value="coloc"/>
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
			<option label="p..gener." value="sem"/>
			<option label="p..restr." value="sem"/>
			<option label="spec." value="sem"/>
			<option label="cu.determinări" value="coloc"/>
			<option label="rar.la" value="gram"/>
			<option label="mai.ales.la" value="gram"/>
			<option label="fact." value="gram"/>
			<option label="intranz." value="gram"/>
			<option label="tranz." value="gram"/>
			<option label="refl." value="gram"/>
			<option label="recipr." value="gram"/>
			<option label="refl..pas." value="gram"/>
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

ua:template("bibl-template",
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
ua:attach-template(ua-dt:css-selector("bibl:not([type = 'author-reference']):before"), "bibl-template"),

ua:template("bibl-buttons-template",
    <template>
        <button onclick="{oxy:xquery-update-action('insertBiblElement')}" style="background-color: transparent; visibility: {count(bibl) = 0};"/>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form > bibl:after, etym > bibl:after"), "bibl-buttons-template"),

ua:template("bibl-ptr-before",
    <template>
        <datalist id="bibliographic-references">
            <option label="" value=""/>
        </datalist>
        <input data-ua-ref="{@target}" size="40" list="bibliographic-references" />
        <button onclick="{oxy:xquery('searchBibliographicReferences')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > ptr"), "bibl-ptr-before"),

ua:template("bibl-date-before",
    <template>
    	Dată:&amp;nbsp;
        <input data-ua-ref="{text()}" size="10" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > date:before"), "bibl-date-before"),

ua:template("bibl-citedRange-before",
    <template>
    	\00000ALocalizare în sursă:&amp;nbsp;
        <input data-ua-ref="{text()}" size="30" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > citedRange:before"), "bibl-citedRange-before"),

ua:template("cit-before",
    <template>
        Atestare:
        <button onclick="{oxy:xquery-update-action('insertBibliographicReferenceAuthor')}" style="background-color: transparent; visibility: {count(bibl/author) = 0};"/>
        <button onclick="{oxy:xquery-update('resources/xquery/insertCitElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
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

ua:template("bibl-author-reference-template",
    <template>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl[type = 'author-reference']:after"), "bibl-author-reference-template"),

ua:template("author-reference-template",
    <template>
	    <datalist id="bibliographic-reference-authors">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="bibliographic-reference-authors" />
	    <button onclick="{oxy:xquery('searchBibliographicReferenceAuthors')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl[type = 'author-reference'] > author:before"), "author-reference-template"),

ua:template("gramGrp-before",
    <template>
        Categorie gramaticală:
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {local-name(parent::*) = ('sense', 'etym') or count(parent::*/gramGrp) > 1};" />        
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
            <option label="s. pr." value="s. pr." />
            <option label="subst." value="subst." />
            <option label="vb." value="vb." />
            <option label="loc." value="loc." />
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
            <option label="sg." value="sg." />
            <option label="pl." value="pl." />
            <option label="invar." value="invar." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 's.'] ~ number:before"), "pos-s-number-before"),

ua:template("subc-articulare-before",
    <template>
        Articulare:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="art." value="art." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 's. pr.'] ~ subc:before, pos[value = 's.'] ~ subc:before"), "subc-articulare-before"),

ua:template("subc-loc.-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="adj." value="adj." />
            <option label="adv." value="adv." />
            <option label="prep." value="prep." />
            <option label="conj." value="conj." />
            <option label="vb." value="vb." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'loc.'] ~ subc:before"), "subc-loc.-before"),

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
            <option label="voc." value="voc." />
            <option label="gen.-dat." value="gen.-dat." />
            <option label="gen.-dat. și" value="gen.-dat. și" />
            <option label="gen.-dat. sg." value="gen.-dat. sg." />
            <option label="gen.-dat. sg. și" value="gen.-dat. sg. și" />
            <option label="gen.-dat. pl." value="gen.-dat. pl." />
            <option label="gen.-dat. pl. și" value="gen.-dat. pl. și" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("case:before"), "case-before"),

ua:template("pos-adj-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="dem." value="dem." />
            <option label="interog.-rel." value="interog.-rel." />
            <option label="nehot." value="nehot." />
            <option label="pos." value="pos." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'adj.'] ~ subc:before"), "pos-adj-subc-before"),

ua:template("pos-adv-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="interog." value="interog." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'adv.'] ~ subc:before"), "pos-adv-subc-before"),

ua:template("pos-art-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="adj." value="adj." />
            <option label="hot." value="hot." />
            <option label="nehot." value="nehot." />
            <option label="pos." value="pos." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'art.'] ~ subc:before"), "pos-art-subc-before"),

ua:template("pos-num-subc-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="adv." value="adv." />
            <option label="card." value="card." />
            <option label="col." value="col." />
            <option label="multipl." value="multipl." />
            <option label="nehot." value="nehot." />
            <option label="ord." value="ord." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'num.'] ~ subc:before"), "pos-num-subc-before"),

ua:template("pos-pron-subc1-before",
    <template>
        Tip:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="dem." value="dem." />
            <option label="interog.-rel." value="interog.-rel." />
            <option label="întăr." value="întăr." />
            <option label="neg." value="neg." />
            <option label="nehot." value="nehot." />
            <option label="pers." value="pers." />
            <option label="pos." value="pos." />
            <option label="refl." value="refl." />
            <option label="de politeţe" value="de politeţe" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'pron.'] ~ subc:nth-of-type(1):before"), "pos-pron-subc1-before"),

ua:template("pos-pron-subc2-before",
    <template>
        Poziție:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="antepus" value="antepus" />
            <option label="postpus" value="postpus" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'pron.'] ~ subc:nth-of-type(2):before"), "pos-pron-subc2-before"),

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
ua:attach-template(ua-dt:css-selector("pos[value='subst.'] ~ number:before, pos[value='pron.'] ~ number:before"), "multiple-number-before"),

ua:template("multiple-per-before",
    <template>
        Persoană:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="la pers. 1" value="la pers. 1" />
            <option label="la pers. 2" value="la pers. 2" />
            <option label="la pers. 3" value="la pers. 3" />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value='pron.'] ~ per:before"), "multiple-per-before"),

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

ua:template("pos-vb-subc-1-before-template",
    <template>
        Tip 1:&amp;nbsp;
        <select data-ua-ref="{@value}" multiple="multiple" data-ua-appearance="oxy:popupWithMultipleSelection">
            <option label="" value="" />
            <option label="fact." value="fact." />
            <option label="intranz." value="intranz." />
            <option label="tranz." value="tranz." />
            <option label="refl. pas." value="refl. pas." />
            <option label="recipr." value="recipr." />
            <option label="refl." value="refl." />
            <option label="impers." value="impers." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value='vb.'] ~ subc:nth-of-type(1):before"), "pos-vb-subc-1-before-template"),

ua:template("pos-vb-subc-2-before-template",
    <template>
        Prezență / absență persoană:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="impers." value="impers." />
            <option label="unipers." value="unipers." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value='vb.'] ~ subc:nth-of-type(2):before"), "pos-vb-subc-2-before-template"),

ua:template("multiple-form-oVar",
    <template>
        Scris şi&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'writing'] > oVar, re[type = 'lexical-variant-section'] > oVar, form[type = 'abbreviation'] > oVar"), "multiple-form-oVar"),

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
        <button onclick="{oxy:xquery-update('resources/xquery/addAccentuationSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unknown-accentuation']:before, form[type = 'accentuation-variant']:before"), "form-accentuation-before")
,
ua:template("form-articulation-before",
    <template>
        Articulat&amp;nbsp;
        <button onclick="{oxy:xquery-update('resources/xquery/addArticulationSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
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
        <input data-ua-ref="{text()}" size="22" />
        \00000A
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" style="visibility: {count(following-sibling::usg) = 0};" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertBiblElement')}" style="visibility: {count(following-sibling::bibl) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("stress"), "stress"),

ua:template("form-pronunciation-before",
    <template>
        Pronunțare
        <button onclick="{oxy:xquery-update('resources/xquery/addPronunciationSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        \00000AIndicaţie de silabaţie
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="bisilabic" value="bisyllabic" />
            <option label="trisilabic" value="trisyllabic" />
        </select>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstSyllabationElement.xq')}" style="visibility: {count(syll) = 0};">Silabație hiat</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstPronElement.xq')}" style="visibility: {count(pron) = 0};">Pron. cuvânt străin</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstPronunciationReferenceElement.xq')}" style="visibility: {count(pRef) = 0};">Pronunţat şi</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementInPronunciationForm.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation']:before"), "form-pronunciation-before"),

ua:template("form-pronunciation-syll",
    <template>
        Silabația secvenței cu hiat&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/addSyllabationElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > syll"), "form-pronunciation-syll"),

ua:template("form-pronunciation-pron",
    <template>
        Pronunțarea cuvântului titlu străin&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/addPronElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > pron"), "form-pronunciation-pron"),

ua:template("form-pronunciation-pRef",
    <template>
        Pronunţat şi&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/addPronunciationReferenceElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation'] > pRef"), "form-pronunciation-pRef"),

ua:template("form-writing-before",
    <template>
        Scriere
        <button onclick="{oxy:xquery-update('resources/xquery/addWritingSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsLastIntoElement.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) > 0};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'writing']:before"), "form-writing-before"),

ua:template("form-abbreviation-before",
    <template>
        Abreviere
        <button onclick="{oxy:xquery-update('resources/xquery/addAbbreviationSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstoVarElement.xq')}" style="visibility: {count(oVar) = 0};">Var. de scriere</button>
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
            <option label="fem. sg. (pentru adj.)" value="grammatical-information-subtype-for-fem-sg" />
        </select>
        \00000A
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
        <input data-ua-ref="{text()}" size="22" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertStressElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb'] > stress"), "form-grammatical-information-for-verb-stress"),

ua:template("form-details-for-grammatical-information-for-verb-before",
    <template>
        Formă&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        \00000A
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'details-for-grammatical-information-for-verb']:before"), "form-details-for-grammatical-information-for-verb-before"),

ua:template("form-details-for-grammatical-information-for-fem-sg-before",
    <template>
        Feminin&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
        \00000A
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-fem-sg'] > term:before"), "form-details-for-grammatical-information-for-fem-sg-before"),

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
        Indicaţii pentru plural
        <button onclick="{oxy:xquery-update('resources/xquery/addGrammaticalInformationForPluralSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementIntoPluralInformationSection.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addGramGrpInForm.xql')}" style="visibility: {count(gramGrp) = 0};">Cat. gram.</button>
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" />
        Nr. sens&amp;nbsp;<input data-ua-ref="{@corresp}" size="10" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::form/form) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-plural']:before"), "form-grammatical-information-for-plural-before"),

ua:template("form-grammatical-information-for-case-before",
    <template>
        Indicaţii pentru caz
        <button onclick="{oxy:xquery-update('resources/xquery/addGrammaticalInformationForCaseSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementIntoCaseInformationSection.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" />
        Nr. sens&amp;nbsp;<input data-ua-ref="{@corresp}" size="10" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::form/form) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-case']:before"), "form-grammatical-information-for-case-before"),

ua:template("form-grammatical-information-for-case-case",
    <template>
        <input data-ua-ref="{text()}" size="22" />      
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-case'] > case"), "form-grammatical-information-for-case-case"),

ua:template("form-grammatical-information-for-verb-before",
    <template>
        \00000AIndicaţii pentru verb
        <button onclick="{oxy:xquery-update('resources/xquery/addGrammaticalInformationForVerbSection.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstStressElement.xq')}" style="visibility: {count(stress) = 0};">Var. acc.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementIntoVerbInformationSection.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" />
        Nr. sens&amp;nbsp;<input data-ua-ref="{@corresp}" size="10" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::form/form) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information-for-verb']:before"), "form-grammatical-information-for-verb-before"),

ua:template("sense-currentEdited-value-before",
    <template>
        Nivel:&amp;nbsp;
        <select data-ua-ref="{@n}" contenteditable="true" style="width: 17px;">
            <option label="◊" value="◊" />
            <option label="♦" value="♦" />
        </select>
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" data-showIcon="false" style="visibility: {count(gramGrp) = 0};" />        
        <button onclick="{oxy:xquery-update('resources/xquery/insertGlobalUsgElementIntoSense.xql')}" style="visibility: {not(element()[1]/local-name() = 'usg' or element()[2]/local-name() = 'usg')};">Ind. fol. globală</button>
    	<button onclick="{oxy:xquery-update('resources/xquery/insertFirstSemanticalUnit.xql')}" style="visibility: {count(form[@type = 'unitate-semantică-subsumată']) = 0};">Expr. etc.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertReference.xql')}">Trimitere</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstLexicalVariant.xql')}" style="visibility: {count(//sense/re[@type = 'lexical-variant-section']) = 0};">Variantă lexicală</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addEtymElementAsLastInto.xql')}">Etimologie</button>     
    </template>
),
ua:attach-template(ua-dt:css-selector("sense:before"), "sense-currentEdited-value-before"),

ua:template("form-unitate-semantică-subsumată",
    <template>
        Unitate semantică subsumată:&amp;nbsp;
        <button onclick="{oxy:xquery-update('resources/xquery/insertSemanticalUnit.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/form[@type = 'unitate-semantică-subsumată']) > 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsFirstIntoElement.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insert-subc-unitate-semantică-subsumată.xql')}" style="visibility: {count(subc) = 0};">Tip verbal</button>
        <button onclick="{oxy:xquery-update-action('addFirstAbbreviationSection')}" style="visibility: {count(form[@type = 'abbreviation']) = 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/addTermOfEtymType.xql')}" style="visibility: {count(term[@type = 'etym']) = 0};">Etimologie</button>
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > form[type = 'unitate-semantică-subsumată']:before"), "form-unitate-semantică-subsumată"),

ua:template("idno-unitate-semantică-subsumată",
    <template>
        Tip:&amp;nbsp;        
		<input data-ua-ref="@type" type="checkbox" id="proverb-checkbox" name="unitate-semantică-subsumată-checkbox" value="proverb" />
		<label for="proverb-checkbox">proverb</label>
		<input data-ua-ref="@type" type="checkbox" id="saying-checkbox" name="unitate-semantică-subsumată-checkbox" value="saying" />
		<label for="saying-checkbox">zicătoare</label>
		<input data-ua-ref="@type" type="checkbox" id="sibyl-checkbox" name="unitate-semantică-subsumată-checkbox" value="sibyl" />
		<label for="saying-checkbox">ghicitoare</label>		
		<input data-ua-ref="@type" type="checkbox" id="syntagma-checkbox" name="unitate-semantică-subsumată-checkbox" value="syntagma" />
		<label for="saying-checkbox">sintagmă</label>
		<input data-ua-ref="@type" type="checkbox" id="phrase-checkbox" name="unitate-semantică-subsumată-checkbox" value="phrase" />
		<label for="saying-checkbox">expresie</label>
		<input data-ua-ref="@type" type="checkbox" id="compound-checkbox" name="unitate-semantică-subsumată-checkbox" value="compound" />
		<label for="saying-checkbox">compus</label>
		<input data-ua-ref="@type" type="checkbox" id="adjectival-locution-checkbox" name="unitate-semantică-subsumată-checkbox" value="adjectival-locution" />
		<label for="saying-checkbox">loc. adj.</label>		
		<input data-ua-ref="@type" type="checkbox" id="adverbial-locution-checkbox" name="unitate-semantică-subsumată-checkbox" value="adverbial-locution" />
		<label for="saying-checkbox">loc. adv.</label>
		<input data-ua-ref="@type" type="checkbox" id="prepositional-locution-checkbox" name="unitate-semantică-subsumată-checkbox" value="prepositional-locution" />
		<label for="saying-checkbox">loc. prep.</label>
		<input data-ua-ref="@type" type="checkbox" id="conjunctional-locution-checkbox" name="unitate-semantică-subsumată-checkbox" value="conjunctional-locution" />
		<label for="saying-checkbox">loc. conj.</label>
		<input data-ua-ref="@type" type="checkbox" id="verbal-locution-checkbox" name="unitate-semantică-subsumată-checkbox" value="verbal-locution" />
		<label for="saying-checkbox">loc. vb.</label>		
    </template>
),
ua:attach-template(ua-dt:css-selector("idno[n = 'tip-unitate-semantică-subsumată']"), "idno-unitate-semantică-subsumată"),

ua:template("term1-unitate-semantică-subsumată",
    <template>
        Conținut:&amp;nbsp;
        <input data-ua-ref="{text()}" size="70" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unitate-semantică-subsumată'] > term:nth-of-type(1):before"), "term1-unitate-semantică-subsumată"),

ua:template("subc-unitate-semantică-subsumată-template",
    <template>
        Tip 1:&amp;nbsp;
        <select data-ua-ref="{@value}" multiple="multiple" data-ua-appearance="oxy:popupWithMultipleSelection">
            <option label="" value="" />
            <option label="fact." value="fact." />
            <option label="intranz." value="intranz." />
            <option label="tranz." value="tranz." />
            <option label="refl. pas." value="refl. pas." />
            <option label="recipr." value="recipr." />
        </select>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unitate-semantică-subsumată'] > subc:before"), "subc-unitate-semantică-subsumată-template"),

ua:template("term2-unitate-semantică-subsumată",
    <template>
        Etimologie:&amp;nbsp;
        {
            $target-languages-template
        }
        <input data-ua-ref="{text()}" size="70" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'unitate-semantică-subsumată'] > term[type = 'etym']:before"), "term2-unitate-semantică-subsumată"),

ua:template("author-before",
    <template>
        Redactor*:&amp;nbsp;
        <select data-ua-ref="{text()}" contenteditable="false">
            <option label="" value="guest" />
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
            <option label="Ștefănescu Maria" value="Maria.Stefanescu" />
            <option label="Tamba Isabella" value="isabelle.tamba" />
            <option label="Teste" value="tests" />
            <option label="Vasilescu Florin" value="FlorinV" />
        </select>
        <button onclick="{oxy:xquery-update('resources/xquery/insertAuthorElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/author) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("titleStmt > author:before"), "author-before"),

ua:template("editor-before",
    <template>
        Revizor*:&amp;nbsp;
        <select data-ua-ref="{text()}" contenteditable="false">
            <option label="guest" value="guest" />
        </select>
        <button onclick="{oxy:xquery-update('resources/xquery/insertEditorElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/editor) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("titleStmt > editor:before"), "editor-before"),

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

ua:template("dlr-senses-tree-template",
    <template>
        {
            ua:get-template(oxy:get-template("ro.dlri.oxygen.templates.tree.TreeFormControl",
                map {
                    "edit" := "#text",
                    "itemLabel" := "concat(@n, ' ', if (form) then concat(string-join(form/term[1], ' | '), ' =') else (), ' ', string-join(def, ' '))",
                    "treeWidth" := "1100",
                    "treeHeight" := "350",
                    "treeParentNodePath" := "//dictScrap[@xml:id = 'dlr-senses']"
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("text[type = 'editing-mode-dlr'] > body > entry > form[type = 'headword']:after"), "dlr-senses-tree-template"),

ua:template("dex-senses-tree-template",
    <template>
        {
            ua:get-template(oxy:get-template("ro.dlri.oxygen.templates.tree.TreeFormControl",
                map {
                    "edit" := "#text",
                    "itemLabel" := "concat(@n, ' ', if (form) then concat(string-join(form/term[1], ' | '), ' =') else (), ' ', string-join(def, ' '))",
                    "treeWidth" := "1100",
                    "treeHeight" := "350",
                    "treeParentNodePath" := "//dictScrap[@xml:id = 'dex-senses']"
                }            
            ))
        }
    </template>
),
ua:attach-template(ua-dt:css-selector("text[type = 'editing-mode-dex'] > body > entry > form[type = 'headword']:after"), "dex-senses-tree-template"),

ua:template("syll",
    <template>
        Despărțire în silabe:&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("syll"), "syll"),

ua:template("sense-def-template",
    <template>
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertSynonym')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertAnalogy')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertAssociation')}" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertAntonym')}" data-showIcon="false" />
        \00000A
        <textarea data-ua-ref="{text()}" cols="70" rows="7" data-contentType="text/plain" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertDefElement.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update('resources/xquery/deleteDefElement.xq')}" style="background-color: transparent; visibility: {count(parent::*/def) > 1};"><img src="../../resources/images/delete.png" /></button>
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > def"), "sense-def-template"),

ua:template("entry-form-headword-before",
    <template>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsLastIntoElement.xql')}" style="background-color: transparent; visibility: {count(usg) = 0};">Ind. fol.</button> 
        \00000A Cuvânt titlu*:&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
        \00000ANumăr ordine omonime:&amp;nbsp;
        <input data-ua-ref="{@n}" size="2" />
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > form[type = 'headword'] > orth"), "entry-form-headword-before"),

ua:template("lexical-variant-section-before",
    <template>
        Variantă lexicală&amp;nbsp;
        <button onclick="{oxy:xquery-update('resources/xquery/addLexicalVariant.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('cloneCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsFirstIntoElement.xql')}" style="visibility: {count(usg) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update-action('addFirstAccentuationSection')}" style="visibility: {count(form[contains(' unknown-accentuation accentuation-variant ', @type)]) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstPronunciationSection')}" style="visibility: {count(form[@type = 'pronunciation']) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstWritingSection')}" style="visibility: {count(form[@type = 'writing']) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstAbbreviationSection')}" style="visibility: {count(form[@type = 'abbreviation']) = 0};" />
        <button onclick="{oxy:xquery-update-action('addFirstGrammaticalInformationSection')}" style="visibility: {count(form[@type = 'grammatical-information']) = 0};" />
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/addEtymElementAsLastInto.xql')}" style="visibility: {local-name(parent::*) = 'entry'};">Etimologie</button>
    </template>
),
ua:attach-template(ua-dt:css-selector("re[type = 'lexical-variant-section']:before"), "lexical-variant-section-before"),

ua:template("def-lexical-variant-section-before",
    <template>
        \00000A
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("re[type = 'lexical-variant-section'] > def:before"), "def-lexical-variant-section-before")
