({
    onInit : function(component, event, helper) {
        var action = component.get("c.getAll");
        var bid = component.get("v.boat.Id");
        console.log('boatreivews bid = ' + bid);
        
         action.setParams({boatId : bid });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("Boatreview  state = " + state);
            if (state === "SUCCESS") {
                console.log("Boatreview = " + response.getReturnValue());
                component.set("v.boatReviews", response.getReturnValue());
                console.log("Boatreview attribute = " + component.get("v.boatReviews"));
                

            }
            
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });

        // optionally set storable, abortable, background flag here

        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    },
})