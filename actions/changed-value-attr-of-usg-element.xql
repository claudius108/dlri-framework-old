xquery version "3.0";

replace value of node @type with for $a in @value return doc('../resources/ontology/usages.html')//*[@label = $a]/@value/string()
