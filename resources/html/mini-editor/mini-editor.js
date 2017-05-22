function bridgeReady () {
	var authorDocumentController = authorAccess.getDocumentController();
	
    var newContent = authorDocumentController.serializeFragmentToXML(authorDocumentController.createDocumentFragment(contextElement.getStartOffset() + 1, contextElement.getEndOffset() - 1));
    newContent = '<div xmlns="http://www.w3.org/1999/xhtml" id="content" contenteditable="true">' + newContent + "</div>";

    var newContentElement = (new DOMParser()).parseFromString(newContent, "text/xml").documentElement;
    
    var contentElement = document.getElementById("content");
    var contentElementParent = contentElement.parentNode;
    contentElementParent.replaceChild(document.importNode(newContentElement, true), contentElement);
}

var buttons = document.querySelectorAll("#toolbar button");

for (var i = 0; i < buttons.length; i++) {
	var button = buttons[i];
	
	button.addEventListener("click", function() {
	    var selection = window.getSelection();
	    var rendAttrValue = this.id;
	    rendAttrValue = rendAttrValue.replace("-button", "");
	    
		if (selection.rangeCount) {
			range = selection.getRangeAt(0);
			
		    var hiElement = document.createElementNS("http://www.tei-c.org/ns/1.0", "hi");
		    hiElement.setAttribute("rend", rendAttrValue);
		    hiElement.textContent = selection.toString();
	    	
	    	range.deleteContents();			
			range.insertNode(hiElement);
		}			    
	}, false);	
}

document.getElementById("save-button").addEventListener("click", function() {
    var content = document.getElementById("content");
    
    var xml = (new XMLSerializer()).serializeToString(content);
    xml = xml.substring(xml.indexOf(">") + 1);
    xml = xml.replace("</div>", "");
    //alert(xml);
    
    var authorDocumentController = authorAccess.getDocumentController();
    var startOffset = contextElement.getStartOffset();
    var endOffset = contextElement.getEndOffset();
    
    if (startOffset + 1 < endOffset) {
        //authorDocumentController.delete(startOffset + 1, endOffset - 1);
        //authorDocumentController.delete(startOffset + 1,endOffset - 1);
    	authorDocumentController[ "delete(int,int)"](startOffset + 1, endOffset - 1);
    }
    
    var authorDocumentFragment = authorDocumentController.createNewDocumentFragmentInContext(xml, startOffset - 1);
    alert(authorDocumentFragment);
    authorDocumentController.insertFragment(startOffset + 1, authorDocumentFragment);
}, false);

document.getElementById("open-button").addEventListener("click", function() {
    // Oxygen's API needs an java.net.URL Java Object so we build it using the "apiHelper".
    var toOpen = apiHelper.newInstance("java.net.URL", ["file:///home/claudius/oxygen/author/frameworks/dlri/resources/html/entries/entries.xml"]);
    // The open method is overloaded. You can pick a specific overloaded method by listing the parameter 
    // types in an extended method name.
    pluginWorkspace["open(java.net.URL,java.lang.String)"](toOpen, "Author");
}, false);
