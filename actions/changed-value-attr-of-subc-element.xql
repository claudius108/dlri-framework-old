xquery version "3.0";

(
    if (@value = ('adj.-empty', 'adv.-empty', 'adj.-pos.', 'adj.-interog.-rel.', 'adj.-dem.', 'adj.-nehot.', 'art.-adj.', 'art.-hot.', 'art.-nehot.',
        'art.-pos.', 'num.-card.', 'num.-col.', 'num.-multipl.', 'num.-nehot.', 'num.-ord.', 'vb.-fact.', 'vb.-intranz.', 'vb.-tranz.',
        'vb.-refl.', 'vb.-pas.', 'vb.-recipr.', 'vb.-impers.', 'vb.-unipers.', 'adv.-interog.'))
    then ()
    else (),            
    if (@value = ('', 'num.-adv.', 'hot.'))
    then (delete nodes parent::*/element()[position() > 2])
    else ()
)
