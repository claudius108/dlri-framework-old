xquery version "3.0";

declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";

let $search-string := lower-case(/*/@target)

    
return dlri-utils:updateDatalist("bibliographic-references", doc("http://188.212.37.221:8080/apps/dlri-app/services/bibliographic-references/bibliographic-references.xq?search-string=" || $search-string))
