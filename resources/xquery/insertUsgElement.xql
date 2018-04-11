xquery version "3.0";

let $context := .

let $processed-template :=
	copy $template := doc('../../content-models/usg.xml')
	modify insert node attribute {'corresp'} {concat('#', $context/@xml:id)} into $template/*
	return $template

return insert node $processed-template after .
