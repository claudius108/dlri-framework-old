xquery version "3.0";

let $author :=
    <bibl xmlns="http://www.tei-c.org/ns/1.0" type="author-reference">
        <author />
    </bibl>
    
return insert node $author as first into .
