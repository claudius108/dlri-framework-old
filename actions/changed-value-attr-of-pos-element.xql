xquery version "3.0";

(
    if (@value = ('', 'adv.', 'conj.', 'interj.', 'prep.'))
    then (delete nodes parent::*/element()[position() > 1])
    else (),
    if (@value = 'adj.')
    then
        (
            delete nodes parent::*/element()[position() > 1],
            insert nodes (doc('../content-models/subc.xml'), doc('../content-models/number.xml')) as last into parent::*
        )
    else (),
    if (@value = ('art.', 'num.', 'pron.'))
    then
        (
            delete nodes parent::*/element()[position() > 1],
            insert node doc('../content-models/subc.xml') as last into parent::*
        )
    else (),
    if (@value = 's.')
    then
        (
            delete nodes parent::*/element()[position() > 1],
            insert nodes (doc('../content-models/gen.xml'), doc('../content-models/number.xml'), doc('../content-models/case.xml'), doc('../content-models/name.xml')) as last into parent::*
        )
    else (),
    if (@value = 'subst.')
    then
        (
            delete nodes parent::*/element()[position() > 1],
            insert node doc('../content-models/number.xml') as last into parent::*
        )
    else (),
    if (@value = 'vb.')
    then
        (
            delete nodes parent::*/element()[position() > 1],
            insert nodes (doc('../content-models/iType.xml'), doc('../content-models/subc.xml')) as last into parent::*
        )
    else ()
)
