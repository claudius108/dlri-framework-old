xquery version "3.0";

declare namespace dlr-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace jp = "java:javax.swing.JOptionPane";

let $search-string := lower-case(/*/@target)


return
	(
		dlr-utils:updateDatalist("headword-references", "", doc("http://188.212.37.221:8080/apps/dlr-app/services/headword-references/headword-references.xq?search-string=" || $search-string))
		,
		jp:showMessageDialog((), "Căutarea s-a efectuat cu succes!")
	)
