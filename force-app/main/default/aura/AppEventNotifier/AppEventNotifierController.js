({
	clickEventNotifier : function(component, event, helper) {
        var appEvent = $A.get("e.c:ApplicationEvent");
        appEvent.setParams({
            "message": "Value from Application Notifier"
        });
        appEvent.fire();
	}
})