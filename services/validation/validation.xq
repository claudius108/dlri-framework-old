xquery version "3.0";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace dlr-utils = "java:ro.dlri.oxygen.plugin.Utils";

declare variable $framework-dir := dlr-utils:expandEditorVariables("${framework(dlri)}");

let $structural-validation-errors := dlr-utils:validate()


return
	(
	    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "resources/css/html.css&quot;")}
	    ,
	    processing-instruction xml-stylesheet {concat("type=&quot;text/css&quot; href=&quot;", $framework-dir, "services/validation/oxygen-render.css&quot;")}
	    ,
	    <html>
	        <head>
	            <title />
	        </head>
	        <body>
	            <h2>Validare structurală (număr de erori găsite: {count($structural-validation-errors)})</h2>
	            <ul>
	                {
	                    for $item in $structural-validation-errors
	                    return <li>{$item}</li>
	                }
	            </ul>
	            <h2>Validare semantică</h2>     
	        </body>
	    </html>
	)
