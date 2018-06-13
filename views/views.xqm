xquery version "3.0";

module namespace dlr-views = "http://lingv.ro/ns/dlr-views";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function dlr-views:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:hi) return dlr-views:hi($node)
        default return dlr-views:passthru($node)
};

declare function dlr-views:passthru($nodes as node()*) as item()* {
    for $node in $nodes/node() return dlr-views:dispatch($node)
};

declare function dlr-views:get-entry($entry-url as xs:string) as node() {
  let $entry-doc := doc(replace($entry-url, " ", "%20"))
  
  return $entry-doc//tei:entry
};

declare function dlr-views:get-page-title($entry as node()) as node() {
  <title>{data($entry/tei:form[@type = 'headword']/tei:orth)}</title>
};

declare function dlr-views:sense($node as element(tei:sense), $content as item()*) as element()+ {
    <div class="sense-level{count($node/ancestor-or-self::tei:sense)}">
        {
            (
                <span class="sense-level">{concat(' ', $node/@level)}</span>,
                if ($node/tei:usg) then <span>{concat(' (', string-join($node/tei:usg, ','), ')')}</span> else (),
                $content
            )
        }
    </div>
};

declare function dlr-views:orth($node as node()) as item()* {
  switch ($node/parent::tei:form/@type)
    case "headword" return dlr-views:orth-headword($node)
    default return ()
};

declare function dlr-views:orth-headword($node as node()) as node()+ {
  (
    <span class="headword">{data($node)}</span>,
    <span class="superscript">{data($node/@n)}</span>,
    <p />
  )
};

declare function dlr-views:form($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:form) return dlr-views:process-form($node)
        case element(tei:hi) return dlr-views:hi($node)
        default return ()
};

declare function dlr-views:process-form($node as node()) as item()* {
  switch ($node/@type)
    case "phrase" return dlr-views:form-phrase($node)
    default return ()
};

declare function dlr-views:hi($node as node()) as node() {
  <span class="{$node/@rend}">{$node/text()}</span>
};
