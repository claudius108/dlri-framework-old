xquery version "1.0";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace dlri-views = "http://dlri.ro/ns/dlri-views";


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
    let $title := data($entry//tei:form[@type = 'main']/tei:orth)
    return
        <title>
            {
                if ($title != '')
                then $title
                else ' '
            }
        </title>
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

declare function dlri-views:form($node as node()) as item()* {
    typeswitch(element {$node/@type} {})
        case element(phrase) return dlri-views:form-phrase($node)
        case element(main) return dlri-views:form-main($node)
        default return ()
};

declare function dlri-views:form-main($node as node()) as item()+ {
  (
    <span class="headword">{data($node/tei:orth)}</span>
    ,
    <span class="superscript">{data($node/tei:orth/@n)}</span>
    ,
    <p />
  )
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

declare function local:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:gramGrp) return local:gramGrp($node)
        case element(tei:sense) return dlri-views:sense($node, local:process-sense-content($node))
        case element(tei:def) return local:def($node)
        case element(tei:cit) return local:cit($node)
        case element(tei:xr) return local:xr($node)
        case element(tei:usg) return local:usg($node)
        case element(tei:citedRange) return local:bibl-citedRange($node)
        case element(tei:form) return dlri-views:form($node)
        case element(tei:hi) return dlri-views:hi($node)
        case element(tei:author) return ()
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
  typeswitch(element {$node/@type} {})
    case element(syn) return local:xr-synonym($node)
    case element(analog) return local:xr-analogy($node)
    case element(asoc) return local:xr-association($node)
    case element(trimitere) return local:xr-reference($node)
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
      <span class="{$node/ancestor::tei:xr/@type}">{concat(' ', $node//tei:oRef)}</span>,
      <span class="superscript">{data($node//tei:oRef/@type)}</span>,
      "(",
      <span class="bold">{ $node//tei:lbl/text()}</span>,
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

<html>
    <head>
        {dlri-views:get-page-title(/)}
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <script type="text/javascript">
            <![CDATA[
                //  onload="window.setTimeout(generate, 3000)"
                function generate() {
                    window.location.reload(true); 
                }
            ]]>
        </script>        
        <style type="text/css">
        <![CDATA[
            #content {
                margin-bottom: 100px;
            }
            .headword, .sense-level, .bold {
              font-weight: bold;
            }
            
            .superscript {
              vertical-align: super;
              font-size: 80%;
            }
            
            .spacing, .analog, .asoc, .trimitere {
              letter-spacing: 0.3em;
              
            }
            
            .quote {
              font-style: italic;
            }            
                   
            #footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                background-color: #E6E6E6;
            }
            
            #footer button {
                margin: 0 20px 10px 0;
            }
            #page-reload-button {
                height: 20px;
                width: 20px;
                background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABmJLR0QA/wD/AP+gvaeTAAABXklEQVQokZWSParCUBCFTwaUiCFil0LQNG5A7BQsLcQFaGNjZSFKBHfgAiwFEQQXINiLiFWwsxUsRIOCWAgWQ8bi5fnzXlJ4url83z3M5Soigm9C7wMzT6fTer1eKBTG47G/Ib+Zz+fpdPp5Xq1WxS+eMJvNwuEwgGw22+/3bdu+3++Bwn6/13UdQKfTcV3Xl/sQ2u02gFKpFETfbrdms/kSEokEgPV6HXRrq9UiouFwKCK4XC4AYrFYEL1cLjVN03U9mUw6joPj8QjAMAxf2nXdYrGoaRqAeDzeaDTAzJFIhIhOp1NQSblcBjCZTLwdfuZer+dL73Y7VVWJ6HA4eMJqtVIURVXVxWLxh75er7lcDkCtVnu9kohYlgUgFApZlrXZbJjZcZzRaGSaJoBUKnU+nz8EZu52u0SEf8lkMtvt9tmJt36xbbtSqRiGASAajebz+cFgwMzvjCJffu8HcgnCJkJHF6UAAAAASUVORK5CYII=);
                background-repeat:no-repeat;
            }            
        ]]>
        </style> 
    </head>
    <body>
        <div id="content">
            {for $node in /node() return local:dispatch($node)}
        </div>
        <div id="footer">
            <button id="page-reload-button" onclick="window.location.reload(true);"/>
            <button style="float: right;" onclick="OxygenAddonBuilder.closeDialogWindow();">Close</button>
        </div>      
    </body>
</html>
