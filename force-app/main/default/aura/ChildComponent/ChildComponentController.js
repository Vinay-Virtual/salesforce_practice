({
    fireComponentEvent : function(component, event) {
        var compEvent = component.getEvent("compEvent");
        compEvent.setParams({
            "message" : "Hello " +
            "World!" });
        compEvent.fire();
    }
})