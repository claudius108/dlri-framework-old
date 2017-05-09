document.getElementById("content").textContent = "text to test with";

var buttons = document.querySelectorAll("#toolbar button");

for (var i = 0; i < buttons.length; i++) {
	var button = buttons[i];
	
	button.addEventListener("click", function() {
	    var selection = window.getSelection();
	    var rendAttrValue = this.id;
	    rendAttrValue = rendAttrValue.replace("-button", "");
	    
		if (selection.rangeCount) {
			range = selection.getRangeAt(0);
			
		    var hiElement = document.createElement("hi");
		    hiElement.setAttribute("rend", rendAttrValue);
		    hiElement.textContent = selection.toString();
	    	
	    	range.deleteContents();			
			range.insertNode(hiElement);
		}			    
	}, false);	
}			

	