xquery version "3.0";

declare default element namespace "http://www.tei-c.org/ns/1.0";

if (element()[1]/local-name() = 'gramGrp')
then insert node doc('../../content-models/usg.xml') after element()[1]
else insert node doc('../../content-models/usg.xml') as first into .
