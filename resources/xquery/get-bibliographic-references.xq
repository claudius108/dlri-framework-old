xquery version "3.0";

declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";

declare variable $currentElementLocation external; 

let $search-string := saxon:eval(saxon:expression($currentElementLocation))/@target
    
return dlri-utils:updateDatalist("bibliographic-references", doc("http://188.212.37.221:8080/apps/dlri-app/services/bibliographic-references/bibliographic-references.xq?search-string=" || $search-string))