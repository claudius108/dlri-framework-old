function bridgeReady() {
	var authorDocumentController = authorAccess.getDocumentController();
	var startOffset = contextElement.getStartOffset();
	var endOffset = contextElement.getEndOffset();	
	var newContent = "";
	
	if (startOffset + 1 < endOffset) {
		var authorDocumentFragment = authorDocumentController["createDocumentFragment(int,int)"](startOffset + 1, endOffset - 1);
	    var newContent = authorDocumentController.serializeFragmentToXML(authorDocumentFragment);
	}

    newContent = '<div xmlns="http://www.w3.org/1999/xhtml" id="content" contenteditable="true">' + newContent + "</div>";

    var newContentElement = (new DOMParser()).parseFromString(newContent, "text/xml").documentElement;
    
    var contentElement = document.getElementById("content");
    var contentElementParent = contentElement.parentNode;
    contentElementParent.replaceChild(document.importNode(newContentElement, true), contentElement);
}

function saveModifiedContent() {
	var contentElement = document.getElementById("content");
  
	var xml = (new XMLSerializer()).serializeToString(contentElement);
	xml = xml.substring(xml.indexOf(">") + 1);
	xml = xml.replace("</div>", "");
	xml = xml.replace("&nbsp;", " ");
	xml = xml.replace("<br />", "");
  
	var authorDocumentController = authorAccess.getDocumentController();
	
    try {
		authorDocumentController.async();
		
		var startOffset = contextElement.getStartOffset();
		var endOffset = contextElement.getEndOffset();
	  
		if (startOffset + 1 < endOffset) {
			authorDocumentController["delete(int,int)"](startOffset + 1, endOffset - 1);
		}
	  
		var authorDocumentFragment = authorDocumentController.createNewDocumentFragmentInContext(xml, startOffset - 1);
		authorDocumentController.insertFragment(startOffset + 1, authorDocumentFragment);
    } finally {
    	authorDocumentController.sync();
    }
    
    var authorEditorAccess = authorAccess.getEditorAccess();
    authorEditorAccess.save();
}

var toolbarButtons = document.querySelectorAll("#toolbar button");

for (var i = 0; i < toolbarButtons.length; i++) {
	var toolbarButton = toolbarButtons[i];
	
	toolbarButton.addEventListener("click", function() {
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

document.addEventListener("DOMSubtreeModified", function(e) {
	saveModifiedContent();
}, false);

document.addEventListener("DOMCharacterDataModified", function() {
	saveModifiedContent();
}, false);
