xquery version "3.0";

module namespace biblio = "http://dlri.ro/ns/biblio/";

declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";

declare function biblio:run($currentElementLocation as xs:string) {
    let $search-string := saxon:eval(saxon:expression($currentElementLocation))/*/text()
    
    return dlri-utils:updateDatalist("bibliographic-entries", doc("http://188.212.37.221:8080/apps/dlri-app/services/bibliographic-references/bibliographic-references.xq?search-string=" || $search-string)/*/text())
};