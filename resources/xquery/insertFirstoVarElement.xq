xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node doc('../../content-models/oVar.xml') after (tei:gramGrp | tei:usg | tei:ptr | tei:gen | tei:bibl | tei:abbr)[last()]
