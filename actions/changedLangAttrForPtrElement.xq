xquery version "3.0";

import module namespace dlri = "http://dlri.ro/ns/dlri/" at "../resources/xquery/dlri.xqm";

(
    if (@type = ('', 'explicații.etimon-apropiat.de.cuv..rom..terminate.în', 'explicații.etimon-diminutiv.al.lui', 'explicații.etimon-cu.schimbare.de.suf.',
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
    	insert node $dlri:term-template as first into .
    )
    else ()
    ,    
    if (@type = ('traducere.etimon', 'traducere.cuvânt.bază', 'explicații.etimon-contaminare.între.….și.…', 'explicații.etimon-prin.înlocuirea.lui.….cu.…', 'nume.propriu'))
    then (
        insert nodes ($dlri:term-template, $dlri:term-template) as first into .
    )
    else ()
    ,    
    if (@type = 'trimitere.(cf.)')
    then (
        insert nodes (doc('../content-models/usg.xml'), $dlri:term-template, $dlri:term-template) as first into .
    )
    else () 
    ,    
    if (@type = ('explicații.etimon-pentru.explicarea.formei.româneşti', 'explicații.etimon-pentru.explicarea.formei.românești.cf.'))
    then (
        insert nodes ($dlri:term-template, $dlri:bibl-template) as first into .
    )
    else ()
    ,    
    if (@type = 'indicații.gramaticale')
    then (
        insert nodes (doc('../content-models/grammatical-information.xml'), $dlri:term-template) as first into .
    )
    else ()
    ,    
    if (@type = 'izvor')
    then (
        insert nodes ($dlri:bibl-template, $dlri:term-template) as first into .
    )
    else () 
    ,    
    if (@type = 'indicație.folosire')
    then (
        insert nodes (doc('../content-models/usg.xml'), $dlri:term-template) as first into .
    )
    else () 
    ,    
    if (@type = 'trimitere.intrare')
    then (
        insert nodes ($dlri:term-template, $dlri:ptr-template) as first into .
    )
    else ()                  
)