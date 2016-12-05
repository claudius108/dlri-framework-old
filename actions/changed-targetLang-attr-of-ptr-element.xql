xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

if (@type = 'una.sau.mai.multe.variante.lexicale-cf.' and @targetLang != 'ro')
then rename node . as "tei:term"
else ()
