({
	showMessageHelper : function(component, event, msg) {
        var messages = event.getParam("arguments");
        var displayMessage = messages.message;
        component.set("v.msg",displayMessage);
        if(msg == 'confirm') {
           component.set("v.className",'success');
        }
        else {
      	   component.set("v.className",'error');
        }   
	},
    removeMessageHelper: function(component, event){
      component.set("v.msg",'');
    }
})