xquery version "3.0";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";

declare variable $framework-dir := dlri-utils:expandEditorVariables("${framework(dlri)}");

(
    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "/resources/css/html.css&quot;")}
    ,
    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "/resources/css/oxygen-render.css&quot;")}
    ,
    <html>
        <head>
            <title />
        </head>
        <body>
            <h2>Validare structurală</h2>
            <ul>
                {
                    for $item in dlri-utils:validate()
                    return <li>{$item}</li>
                }
            </ul>
            <h2>Validare semantică</h2>     
        </body>
    </html>
)
