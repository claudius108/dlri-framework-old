xquery version "3.0";

declare default element namespace "http://www.tei-c.org/ns/1.0";

insert node doc('../../content-models/usg.xml') after (stress | form[@type = 'details-for-grammatical-information-for-verb'])[last()]
