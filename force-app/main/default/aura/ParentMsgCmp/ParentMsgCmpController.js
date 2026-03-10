({
	handleShowMessage : function(component, event, helper) {
		component.find("messages").show('Confirmation Msg');
	},
    handleShowErrorMessage: function(component, event, helper){
        component.find("messages").error('Error Msg');
    },
    handleRemoveMessage: function(component, event, helper){
        component.find("messages").remove();
    }
})