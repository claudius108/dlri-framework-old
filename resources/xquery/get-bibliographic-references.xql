xquery version "3.0";

declare namespace dlr-utils = "java:ro.dlri.oxygen.plugin.Utils";
declare namespace jp = "java:javax.swing.JOptionPane";

let $search-string := lower-case(/*/text())

    
return jp:showMessageDialog((), "Căutarea s-a efectuat cu succes!")
