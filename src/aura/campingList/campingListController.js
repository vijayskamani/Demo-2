({           
    // Load camping items from Salesforce
    doInit: function(component, event, helper) {
        
        console.log("call c.getItems: ");
        // Create the action
        var action = component.get("c.getItems");
        console.log("back from c.getItems: ");
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        // Send action off to be executed
        $A.enqueueAction(action);
    }, //doInit
    
    handleAddItem: function(component, event, helper) {
        var newItem = event.getParam("item");
        helper.addItem(component, newItem);
        /*             
        var action = component.get("c.saveItem");
        action.setParams({
            "item": newItem
        });
       
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {       
                var items = component.get("v.items");
                items.push(item);
                component.set("v.items",items);
            }
        });
        $A.enqueueAction(action);
        */
    },
    
    handleUpdateItem: function(component, event, helper) {
        var updatedItem = event.getParam("item");
        helper.updateItem(component, updatedItem);
    }
    
})