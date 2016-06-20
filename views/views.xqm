xquery version "3.0";

module namespace dlri-views = "http://dlri.ro/ns/dlri-views";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function dlri-views:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:hi) return dlri-views:hi($node)
        default return dlri-views:passthru($node)
};

declare function dlri-views:passthru($nodes as node()*) as item()* {
    for $node in $nodes/node() return dlri-views:dispatch($node)
};

declare function dlri-views:get-entry($entry-url as xs:string) as node() {
  let $entry-doc := doc(replace($entry-url, " ", "%20"))
  
  return $entry-doc//tei:entry
};

declare function dlri-views:get-page-title($entry as node()) as node() {
  <title>{data($entry/tei:form[@type = 'headword']/tei:orth)}</title>
};

declare function dlri-views:sense($node as element(tei:sense), $content as item()*) as element()+ {
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

declare function dlri-views:orth($node as node()) as item()* {
  switch ($node/parent::tei:form/@type)
    case "headword" return dlri-views:orth-headword($node)
    default return ()
};

declare function dlri-views:orth-headword($node as node()) as node()+ {
  (
    <span class="headword">{data($node)}</span>,
    <span class="superscript">{data($node/@n)}</span>,
    <p />
  )
};

declare function dlri-views:form($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:form) return dlri-views:process-form($node)
        case element(tei:hi) return dlri-views:hi($node)
        default return ()
};

declare function dlri-views:process-form($node as node()) as item()* {
  switch ($node/@type)
    case "phrase" return dlri-views:form-phrase($node)
    default return ()
};

declare function dlri-views:form-phrase($node as node()) as item()+ {
  (
    <span class="spacing">Expr.</span>,
    dlri-views:passthru($node)
  )
};

declare function dlri-views:hi($node as node()) as node() {
  <span class="{$node/@rend}">{$node/text()}</span>
};
