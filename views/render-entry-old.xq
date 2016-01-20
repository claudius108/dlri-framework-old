xquery version "3.0";

import module namespace dlri-views = "http://dlri.ro/ns/dlri-views" at "http://54.235.80.220/apps/dlri-app/services/views.xqm";
import module namespace request = "http://exist-db.org/xquery/request";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function local:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:orth) return dlri-views:orth($node)
        case element(tei:gramGrp) return local:gramGrp($node)
        case element(tei:sense) return dlri-views:sense($node, local:process-sense-content($node))
        case element(tei:def) return local:def($node)
        case element(tei:cit) return local:cit($node)
        case element(tei:xr) return local:xr($node)
        case element(tei:usg) return local:usg($node)
        case element(tei:citedRange) return local:bibl-citedRange($node)
        case element(tei:form) return dlri-views:form($node)
        default return local:passthru($node)
};

declare function local:passthru($nodes as node()*) as item()* {
    for $node in $nodes/node() return local:dispatch($node)
};

declare function local:gramGrp($node as node()) as node() {
    <span> {concat(' ', string-join($node/tei:pos/@value, ' '), ' ', $node/tei:gen/@value)}</span>
};

declare function local:process-sense-content($node as element(tei:sense)) as item()* {
  local:passthru($node)
};

declare function local:def($node as node()) as node() {
    <span>{concat(' ', $node)}</span>
};

declare function local:bibl-citedRange($node as node()) as node() {
    <span class="bibl-ref-id">{concat(', ', $node, '.')}</span>
};

declare function local:cit($node as node()) as node()+ {
  let $bibl := $node/tei:bibl
  return
    (
      <span class="quote">{concat(' ', $node/tei:quote)}</span>,
      <span class="bibl-ref-id">{concat(' ', $bibl/tei:ptr/@target)}</span>,
      <span class="bibl-ref-id">{concat(' ', $bibl/tei:date)}</span>,
      local:bibl-citedRange($bibl/tei:citedRange)
    )
};

declare function local:xr($node as node()) as item()* {
  switch ($node/@type)
    case "syn" return local:xr-synonym($node)
    case "analog" return local:xr-analogy($node)
    case "asoc" return local:xr-association($node)
    case "trimitere" return local:xr-reference($node)
    default return ()
};

declare function local:xr-synonym($node as node()) as item()+ {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'syn']) eq 0) then ";" else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'syn']) eq 0) then ". " else ()
  )
};

declare function local:xr-analogy($node as node()) as item()+ {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'analog']) eq 0) then "V. " else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'analog']) eq 0) then ". " else ()
  )
};

declare function local:xr-association($node as node()) as item()+ {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'asoc']) eq 0) then "Cf. " else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'asoc']) eq 0) then ". " else ()
  )
};

declare function local:xr-reference($node as node()) as item()+ {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'trimitere']) eq 0) then "v. " else "",
      <span class="{$node/ancestor::tei:xr/@type}">{concat(' ', $node/@target)}</span>,
      <span class="superscript">{data($node/@target)}</span>,
      "(",
      <span class="bold">{data($node/@target)}</span>,
      ")",
    if (count($node/following-sibling::tei:xr[@type = 'trimitere']) eq 0) then ". " else ()
  )
};

declare function local:usg($node as node()) as item()+ {
  (
    if (count($node/preceding-sibling::tei:xr[@type = 'syn']) eq 0) then " (" else ", ",
    local:passthru($node),
    if (count($node/following-sibling::tei:xr[@type = 'syn']) eq 0) then ")" else ()
  )
};

let $entry := dlri-views:get-entry(request:get-parameter("entry", ""))


return
  <html>
    <head>
      <link rel="stylesheet" type="text/css" href="render-entry.css"/>
      {dlri-views:get-page-title($entry)}
    </head>
    <body>
      {for $node in $entry/node() return local:dispatch($node)}
    </body>
  </html>
