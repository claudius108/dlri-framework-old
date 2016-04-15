xquery version "3.0";

module namespace headword-references = "http://dlri.ro/ns/headword-references/";

declare namespace dlri-utils = "java:ro.dlri.oxygen.plugin.Utils";

declare function headword-references:run($currentElementLocation as xs:string) {
    let $search-string := saxon:eval(saxon:expression($currentElementLocation))/*/text()
    
    return dlri-utils:updateDatalist("headword-references", doc("http://188.212.37.221:8080/apps/dlri-app/services/headword-references/headword-references.xq?search-string=" || $search-string)/*/text())
};