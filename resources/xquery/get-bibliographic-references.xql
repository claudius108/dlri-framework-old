xquery version "3.0";

declare namespace dlr-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace jp = "java:javax.swing.JOptionPane";

let $search-string := lower-case(/*/@target)

    
return
	(
		let $references := unparsed-text-lines("http://188.212.37.221/apps/dlr/api/bibliography/sigla?q=" || $search-string)
		let $labels := $references[1]
		let $values := $references[2]
		
		return dlr-utils:updateDatalist("bibliographic-references", $labels, $values)
		,
		jp:showMessageDialog((), "Căutarea s-a efectuat cu succes!")
	)
