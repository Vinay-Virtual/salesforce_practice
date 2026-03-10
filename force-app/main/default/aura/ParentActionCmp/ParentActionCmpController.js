({
	handleParentAction : function(component, event, helper) {
		var childCmp = component.find('msg');
        component.set("v.valueFromChild",childCmp.get('v.valueForChild'));
	}
})