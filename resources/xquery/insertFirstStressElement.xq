xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

insert node doc('../../content-models/stress.xml') after tei:form[@type = 'details-for-grammatical-information-for-verb']
