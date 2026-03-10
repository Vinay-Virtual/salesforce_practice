({
    doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Id', fieldName: 'Id', type: 'text'},
            {label: 'Contact name', fieldName: 'Name', type: 'text'},
        ]);


        var actions = component.get("c.getContactList");
        actions.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                var responseList = response.getReturnValue();
                console.log('responseList==>'+responseList);
                component.set("v.ContactList", responseList);
            }
        })
        $A.enqueueAction(actions);
    }
})