function bridgeReady() {
}

function refreshContent() {
	var location = window.location.pathname;
	var renderedFileName = location.substring(location.lastIndexOf('/') + 1);
	renderedFileName = renderedFileName.substring(0, renderedFileName.lastIndexOf('.'));
	
	var optionsStorage = pluginWorkspace.getOptionsStorage();
	var renderedEditorLocation = optionsStorage.getOption(renderedFileName, "");
	
	var renderedEditorAccess = pluginWorkspace.getEditorAccess(new URL(renderedEditorLocation), pluginWorkspace.MAIN_EDITING_AREA);
	
	alert(renderedEditorAccess);	
	
	
	
}
