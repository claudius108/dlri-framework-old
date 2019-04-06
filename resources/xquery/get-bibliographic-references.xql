xquery version "3.0";

declare namespace dlr-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace jp = "java:javax.swing.JOptionPane";

let $search-string := lower-case(/*/@target)

    
return
	(
		dlr-utils:updateDatalist("bibliographic-references", "", doc("http://188.212.37.221/apps/dlr/api/bibliography/sigla?q=" || $search-string))
		,
		jp:showMessageDialog((), "Căutarea s-a efectuat cu succes!")
	)
