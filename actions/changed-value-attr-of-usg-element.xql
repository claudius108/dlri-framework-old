xquery version "3.0";

replace value of node @type with for $a in @value return doc('../content-models/usg-datalist.xml')//*[@label = $a]/@value/string()
