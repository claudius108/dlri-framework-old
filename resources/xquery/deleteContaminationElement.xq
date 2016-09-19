xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

delete nodes (. | preceding-sibling::tei:term[1])
