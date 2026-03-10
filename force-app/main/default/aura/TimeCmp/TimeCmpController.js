({
	doinit : function(component, event, helper) {
		component.set("v.dateValue", new Date());
        alert(component.get("v.selectedArray"));
	}
})