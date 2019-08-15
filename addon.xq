xquery version "3.0";

import module "http://expath.org/ns/user-agent/";

declare namespace ua-dt = "http://expath.org/ns/user-agent/datatype/";
declare namespace oxy = "http://www.oxygenxml.com/extensions/author";

declare variable $ua:document := /;

declare variable $languages-template as element() :=
	<template>
		<datalist id="languages" />
		<select data-ua-ref="{@xml:lang}" contenteditable="false" list="languages" />
	</template>
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
    oxy:execute-xquery-update-script("resources/xquery/insertFirstBiblElement.xql")   
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
    "cloneXrElement",
    map { 
        "name" := "Duplicare",
        "smallIconPath" := "../../resources/images/add.png"       
    },   
    oxy:execute-xquery-update-script("resources/xquery/cloneXrElement.xql")
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
    oxy:execute-xquery-update-script("resources/xquery/insertSynonym.xql")  
),
ua:action(
    "insertAnalogy",
    map { 
        "name" := "Analogie",
        "smallIconPath" := "../../resources/images/add.png"        
    }, 
    oxy:execute-xquery-update-script("resources/xquery/insertAnalogy.xql")  
),
ua:action(
    "insertAssociation",
    map { 
        "name" := "Asociație",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertAssociation.xql")
),
ua:action(
    "insertAntonym",
    map { 
        "name" := "Antonim",
        "smallIconPath" := "../../resources/images/add.png"
    },
    oxy:execute-xquery-update-script("resources/xquery/insertAntonym.xql")
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
ua:attach-template(ua-dt:css-selector("form[type = 'grammatical-information']:before"), "grammatical-information-form")
,
ua:template("dicScrap-usg-before",
    <template>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("dictScrap[rend = 'usg']:before"), "dicScrap-usg-before")
,
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
ua:attach-template(ua-dt:css-selector("ptr[type = 'trimitere']:before"), "trimitere-before")
,
ua:template("sense-xr-before",
    <template>
        <button onclick="{oxy:xquery-update-action('cloneXrElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsLastIntoElement.xql')}" style="visibility: {@type = 'syn' and count(dictScrap[@rend =  'usg']) = 0};">Ind. fol.</button> 
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > xr:before"), "sense-xr-before")
,
ua:template("syn-before",
    <template>
        Sinonim&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />      
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'syn'] > ptr:before"), "syn-before")
,
ua:template("analog-before",
    <template>
        Analogie&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />    
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'analog'] > ptr:before"), "analog-before")
,
ua:template("asoc-before",
    <template>
        Asociație&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />     
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'asoc'] > ptr:before"), "asoc-before")
,
ua:template("antonim-before",
    <template>
        În  opoziţie cu&amp;nbsp;
	    <datalist id="headword-references">
	        <option label="" value=""/>
	    </datalist>
	    <input data-ua-ref="{@target}" size="40" list="headword-references" />
	    <button onclick="{oxy:xquery('searchHeadwordReferences')}" style="background-color: transparent;" />       
        <button onclick="{oxy:xquery-update-action('insertAntonym')}" style="background-color: transparent;" />
    </template>
),
ua:attach-template(ua-dt:css-selector("xr[type = 'antonim'] > ptr:before"), "antonim-before")
,
ua:template("nume.latinesc.definiție.sens-template",
    <template>
        Nume lat.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
		<button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />        
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > def ~ term"), "nume.latinesc.definiție.sens-template")
,
ua:template("etym-before",
    <template>
        <button onclick="{oxy:xquery-update('resources/xquery/addEtymElementAfter.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::entry/etym) > 1 or count(parent::sense/etym) > 0 or parent::re[@type = 'lexical-variant-section']};" />
        Probabilitate etimologie&amp;nbsp;
        <input data-ua-ref="{@cert}" type="radio" value="high">sigur</input>
        <input data-ua-ref="{@cert}" type="radio" value="low">probabil</input>      
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {idno[1]/@type = 'cuvântul.titlu-element.de.substrat' and count(bibl) = 0};" />
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" data-showIcon="false" style="visibility: {idno[starts-with(@type, 'cuvântul.titlu-formație.internă-trimitere-')] and count(gramGrp) = 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstEtymologicalNote.xq')}" style="visibility: {count(note) = 0};">Notă</button>
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

ua:template("element.extern-calc-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }
        &amp;nbsp;Calc după&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type = 'element.extern-calc'] ~ term"), "element.extern-calc-template"),

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

ua:template("variantă-directă-etimon.variantă-template",
    <template>
        Limba&amp;nbsp;
        {
            $languages-template
        }    
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("etym > idno[type ^= 'variantă-directă-etimon.variantă'] ~ term"), "variantă-directă-etimon.variantă-template"),

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
            <option label="cuv. lat." value="cuv. lat." />
            <option label="cuv. it." value="cuv. it." />
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
        <datalist id="etymological-note-types" />
        <select data-ua-ref="{@type}" contenteditable="false" list="etymological-note-types" />
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
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-3da5e0a5-9c68-3bb8-b68a-69151380ca62'] > term:nth-of-type(2):before"), "etym-note-traducere.etimon-term-template"),

ua:template("etym-note-traducere.cuvânt.bază-term-template",
    <template>
    	Traducere cuvânt bază&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-450e4af3-9749-3ed8-9bd0-b8a53c30a8a0'] > term:nth-of-type(2):before"), "etym-note-traducere.cuvânt.bază-term-template"),

ua:template("etym-note-languages-term-template",
    <template>
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-a863aae7-47d7-379f-ba70-3c7e1093f37d'] > term:nth-of-type(1):before, note[type = 'uuid-691bd716-15c8-3e7f-a65a-3913e069704e'] > term:nth-of-type(1):before, 
note[type ~= 'uuid-bf82a126-1e54-3766-aa59-af0085ccd638'] > term:nth-of-type(1):before, note[type = 'uuid-0a31c9cc-4252-355e-87cc-e1ca516dacdb'] > term:nth-of-type(1):before,
note[type = 'uuid-9d0f4561-7312-3d4c-8db5-119c6a852071'] > term:nth-of-type(1):before"), "etym-note-languages-term-template"),

ua:template("etym-note-term2-template",
    <template>
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-bbc29f17-a728-3ebb-931d-56249488fb3d'] > term:nth-of-type(2):before,
note[type = 'uuid-c2e64e06-d14b-308e-8802-5104b95b860f'] > term:nth-of-type(2):before"), "etym-note-term2-template")
,
ua:template("etym-note-trimitere.(cf.)-term2-template",
    <template>
        traducere&amp;nbsp;   
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-9d0f4561-7312-3d4c-8db5-119c6a852071'] > term:nth-of-type(2):before"), "etym-note-trimitere.(cf.)-term2-template")
,
ua:template("etym-note-nume.propriu-term1-template",
    <template>
    	De la numele propriu&amp;nbsp;
        {
            $languages-template
        }
        <input data-ua-ref="{text()}" size="22" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-dee348f1-d8b7-387d-bb51-5dfabfb1dd99'] > term:nth-of-type(1):before"), "etym-note-nume.propriu-term1-template")
,
ua:template("etym-note-nume.propriu-term2-template",
    <template>
    	&amp;nbsp;+ suf.&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-dee348f1-d8b7-387d-bb51-5dfabfb1dd99'] > term:nth-of-type(2):before"), "etym-note-nume.propriu-term2-template")
,
ua:template("etym-note-izvor-term-template",
    <template>
    	Explicații din izvor&amp;nbsp;
        <input data-ua-ref="{text()}" size="22" />
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-c23988ce-0a96-34e3-82fb-a07af5058502'] > term:nth-of-type(1):before"), "etym-note-izvor-term-template")
,
ua:template("etym-note-trimitere.intrare-term2-template",
    <template>
    	Nr. omonim&amp;nbsp;<input data-ua-ref="{@corresp}" size="10" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-06c1a37f-bd24-3e45-ab93-02147fcebe5d'] > term:nth-of-type(2):before"), "etym-note-trimitere.intrare-term2-template")
,
ua:template("etym-note-trimitere.intrare-term3-template",
    <template>
    	Nr. sens&amp;nbsp;<input data-ua-ref="{@corresp}" size="10" /> 
    </template>
),
ua:attach-template(ua-dt:css-selector("note[type = 'uuid-06c1a37f-bd24-3e45-ab93-02147fcebe5d'] > term:nth-of-type(3):before"), "etym-note-trimitere.intrare-term3-template")
,
ua:template("bibl-template",
    <template>
        Izvor:&amp;nbsp;
        <select data-ua-ref="{@type}" contenteditable="false" style="width: 10px;">
            <option label="" value="unknown" />
            <option label="ap." value="ap." />
            <option label="cf." value="cf." />
            <option label="în" value="în" />
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
ua:attach-template(ua-dt:css-selector("form > bibl:after, etym > bibl:after, re > bibl:after"), "bibl-buttons-template"),

ua:template("bibl-date-before",
    <template>
    	Dată:&amp;nbsp;
        <input data-ua-ref="{text()}" size="10" />
    </template>
),
ua:attach-template(ua-dt:css-selector("bibl > date:before"), "bibl-date-before"),

ua:template("cit-before",
    <template>
        Atestare:
        <select data-ua-ref="{@type}" contenteditable="false" style="width: 10px;">
            <option label="" value="unknown" />
            <option label="✧ POP." value="✧ POP." />            
            <option label="▭" value="▭" />
        </select>        
        <button onclick="{oxy:xquery-update-action('insertBibliographicReferenceAuthor')}" style="background-color: transparent; visibility: {count(bibl/author) = 0};"/>
        <button onclick="{oxy:xquery-update('resources/xquery/insertCitElement.xq')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::sense/cit) > 1};" />
    </template>
),
ua:attach-template(ua-dt:css-selector('cit:before'), "cit-before"),

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
ua:attach-template(ua-dt:css-selector("gen:before"), "gen-before")
,
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
ua:attach-template(ua-dt:css-selector("pos[value = 's.'] ~ gen:before"), "pos-s-gen-before")
,
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
ua:attach-template(ua-dt:css-selector("pos[value = 's.'] ~ number:before"), "pos-s-number-before")
,
ua:template("subc-articulare-before",
    <template>
        Articulare:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="art." value="art." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 's. pr.'] ~ subc:before, pos[value = 's.'] ~ subc:before, pos[value = 'pron.'] ~ subc:nth-of-type(3):before"), "subc-articulare-before")
,
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
ua:attach-template(ua-dt:css-selector("pos[value = 'loc.'] ~ subc:before"), "subc-loc.-before")
,
ua:template("pos-adj-number-before",
    <template>
        Număr:&amp;nbsp;
        <select data-ua-ref="{@value}" contenteditable="false">
            <option label="" value="" />
            <option label="invar." value="invar." />
        </select>
    </template>
),
ua:attach-template(ua-dt:css-selector("pos[value = 'adj.'] ~ number:before"), "pos-adj-number-before")
,
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
            <option label="refl. impers." value="refl. impers." />
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
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" style="visibility: {count(following-sibling::dictScrap[@rend =  'usg']) = 0};" data-showIcon="false" />
        <button onclick="{oxy:xquery-update-action('insertBiblElement')}" style="visibility: {count(following-sibling::bibl) = 0};" data-showIcon="false" />
    </template>
),
ua:attach-template(ua-dt:css-selector("stress"), "stress")
,
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
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstPronElement.xq')}" style="visibility: {count(pron) = 0};">Pron.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstPronunciationReferenceElement.xq')}" style="visibility: {count(pRef) = 0};">Pronunţat şi</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementInPronunciationForm.xql')}" style="visibility: {count(dictScrap[@rend =  'usg']) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update-action('insertFirstBiblElement')}" style="visibility: {count(bibl) = 0};" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'pronunciation']:before"), "form-pronunciation-before"),

ua:template("form-pronunciation-pron",
    <template>
        Pronunțat&amp;nbsp;
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
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsLastIntoElement.xql')}" style="visibility: {count(dictScrap[@rend =  'usg']) = 0};">Ind. fol.</button>
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
            <option label="pers. 1 şi" value="pers. 1 şi" />
            <option label="pers. 2 şi" value="pers. 2 şi" />
            <option label="pers. 3 şi" value="pers. 3 şi" />
            <option label="pers. 4 şi" value="pers. 4 şi" />
            <option label="pers. 5 şi" value="pers. 5 şi" />
            <option label="pers. 6 şi" value="pers. 6 şi" />            
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
            <option label="✦" value="✦" />
            <option label="✧" value="✧" />
        </select>
        <button onclick="{oxy:xquery-update-action('addGramGrp')}" data-showIcon="false" style="visibility: {count(gramGrp) = 0};" />        
        <button onclick="{oxy:xquery-update('resources/xquery/insertGlobalUsgElementIntoSense.xql')}" style="visibility: {count(dictScrap[@rend =  'usg']) = 0};">Ind. fol. globală</button>
    	<button onclick="{oxy:xquery-update('resources/xquery/insertFirstSemanticalUnit.xql')}" style="visibility: {count(form[@type = 'unitate-semantică-subsumată']) = 0};">Expr. etc.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertReference.xql')}" style="visibility: {count(ptr[@type = 'trimitere']) = 0};">Trimitere</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addFirstLexicalVariant.xql')}" style="visibility: {count(//sense/re[@type = 'lexical-variant-section']) = 0};">Variantă lexicală</button>
        <button onclick="{oxy:xquery-update('resources/xquery/addEtymElementAsLastInto.xql')}" style="visibility: {count(etym) = 0};">Etimologie</button>     
    </template>
),
ua:attach-template(ua-dt:css-selector("sense:before"), "sense-currentEdited-value-before"),

ua:template("form-unitate-semantică-subsumată",
    <template>
        Unitate semantică subsumată:&amp;nbsp;
        <button onclick="{oxy:xquery-update('resources/xquery/insertSemanticalUnit.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent; visibility: {count(parent::*/form[@type = 'unitate-semantică-subsumată']) > 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsFirstIntoElement.xql')}" style="visibility: {count(dictScrap[@rend =  'usg']) = 0};">Ind. fol.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insert-subc-unitate-semantică-subsumată.xql')}" style="visibility: {count(subc) = 0};">Tip verbal</button>
        <button onclick="{oxy:xquery-update-action('addFirstAbbreviationSection')}" style="visibility: {count(form[@type = 'abbreviation']) = 0};" />
        <button onclick="{oxy:xquery-update('resources/xquery/addTermOfEtymType.xql')}" style="visibility: {count(term[@type = 'etym']) = 0};">Etimologie</button>
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > form[type = 'unitate-semantică-subsumată']:before"), "form-unitate-semantică-subsumată"),

ua:template("idno-unitate-semantică-subsumată",
    <template>
        Tip:&amp;nbsp;
	    <datalist id="semantic-units" />
	    <input type="checkbox" data-ua-ref="{@type}" size="40" list="semantic-units" />
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
            <option label="refl." value="refl." />
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
		<datalist id="redactors" />
		<select data-ua-ref="{text()}" contenteditable="false" list="redactors" />
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

ua:template("sense-def-before-template",
    <template>
        <button onclick="{oxy:xquery-update-action('insertUsgElement')}" data-showIcon="false" style="visibility: {let $context := . return count($context/following-sibling::dictScrap[@corresp = concat('#', $context/@xml:id)]) = 0};"/>
        <button onclick="{oxy:xquery-update-action('insertSynonym')}" data-showIcon="false" style="visibility: {let $context := . return count($context/following-sibling::xr[@type = 'syn' and @corresp = concat('#', $context/@xml:id)]) = 0};"/>
        <button onclick="{oxy:xquery-update-action('insertAnalogy')}" data-showIcon="false" style="visibility: {let $context := . return count($context/following-sibling::xr[@type = 'analog' and @corresp = concat('#', $context/@xml:id)]) = 0};"/>
        <button onclick="{oxy:xquery-update-action('insertAssociation')}" data-showIcon="false" style="visibility: {let $context := . return count($context/following-sibling::xr[@type = 'asoc' and @corresp = concat('#', $context/@xml:id)]) = 0};"/>
        <button onclick="{oxy:xquery-update-action('insertAntonym')}" data-showIcon="false" style="visibility: {let $context := . return count($context/following-sibling::xr[@type = 'antonim' and @corresp = concat('#', $context/@xml:id)]) = 0};"/>
        <button onclick="{oxy:xquery-update('resources/xquery/insertLatinName.xql')}" style="visibility: {let $context := . return count($context/following-sibling::term[@corresp = concat('#', $context/@xml:id)]) = 0};">Nume lat.</button>
        <button onclick="{oxy:xquery-update('resources/xquery/insertDefElement.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update('resources/xquery/deleteDefElement.xql')}" style="background-color: transparent; visibility: {count(parent::*/def) > 1};"><img src="../../resources/images/delete.png" /></button>
        \00000A
    </template>
),
ua:attach-template(ua-dt:css-selector("sense > def:before"), "sense-def-before-template"),

ua:template("entry-form-headword-before",
    <template>
        \00000A Cuvânt titlu (neaccentuat):&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
        \00000ANumăr ordine omonime:&amp;nbsp;
        <input data-ua-ref="{@n}" size="2" />
    </template>
),
ua:attach-template(ua-dt:css-selector("entry > form[type = 'headword'] > orth"), "entry-form-headword-before")
,
ua:template("headword-stress",
    <template>
        Cuvânt titlu (accentuat):&amp;nbsp;
        <input data-ua-ref="{text()}" size="40" />
    </template>
),
ua:attach-template(ua-dt:css-selector("form[type = 'headword'] > stress"), "headword-stress")
,
ua:template("lexical-variant-section-before",
    <template>
        Variantă lexicală&amp;nbsp;
        <button onclick="{oxy:xquery-update('resources/xquery/addLexicalVariant.xql')}" style="background-color: transparent;"><img src="../../resources/images/add.png" /></button>
        <button onclick="{oxy:xquery-update-action('cloneCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update-action('deleteCurrentElement')}" style="background-color: transparent;" />
        <button onclick="{oxy:xquery-update('resources/xquery/insertFirstUsgElementAsFirstIntoElement.xql')}" style="visibility: {count(dictScrap[@rend =  'usg']) = 0};">Ind. fol.</button>
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
