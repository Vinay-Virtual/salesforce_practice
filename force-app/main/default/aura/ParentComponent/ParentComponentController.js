({
    handleCmpEvent: function(component, event) {
        var message = event.getParam("message");
        component.set("v.messageTemp", message);
    }
})