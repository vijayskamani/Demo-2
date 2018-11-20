({  
    clickPacked: function(component, event, helper) {
        var campingItem = component.get("v.item");
        var updateEvent = component.getEvent("updateItem");
        updateEvent.setParams({ "item": campingItem });
        updateEvent.fire();
    } 
})