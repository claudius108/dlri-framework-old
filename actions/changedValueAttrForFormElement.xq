xquery version "3.0";

if (@type = 'accentuation-variant')
then insert node doc('../content-models/stress.xml') as first into .
else delete nodes element()
