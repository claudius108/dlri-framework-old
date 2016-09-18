xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node doc('../../content-models/gen.xml') after (tei:number | tei:usg | tei:gramGrp | tei:ptr)[last()]
