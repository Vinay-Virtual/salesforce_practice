({
	handleAppEvent : function(component, event, helper) {
		var message = event.getParam('message');
        component.set("v.messageFromNotifier", message);
	}
})