xquery version "3.0";

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
            insert nodes (doc('../content-models/gen.xml'), doc('../content-models/number.xml')) as last into parent::*
        )
    else (),
    if (@value = 'pron.-întăr.')
    then
        (
            delete nodes parent::*/element()[position() > 2]
            ,
            insert nodes (doc('../content-models/gen.xml'), doc('../content-models/per.xml')) as last into parent::*
        )
    else (),
    if (@value = ('pron.-pers.', 'pron.-pos.', 'pron.-de politeţe'))
    then
        (
            delete nodes parent::*/element()[position() > 2]
            ,
            insert nodes (doc('../content-models/per.xml'), doc('../content-models/gen.xml'), doc('../content-models/number.xml')) as last into parent::*
        )
    else (),
    if (@value = 'pron.-refl.')
    then
        (
            delete nodes parent::*/element()[position() > 2]
            ,
            insert nodes (doc('../content-models/per.xml'), doc('../content-models/number.xml')) as last into parent::*
        )
    else ()
)
