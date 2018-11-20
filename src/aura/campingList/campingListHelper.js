({
              
   addItem: function(component, campItem) {
       
        /* old version
        var action = component.get("c.addItem");
        action.setParams({ "campItem": item });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
            }
        });
        $A.enqueueAction(action);
        */
      
       this.saveItem(component, campItem, function(response){
       var state = response.getState();
           if (component.isValid() && state === "SUCCESS") {
               var expenses = component.get("v.items");
               expenses.push(response.getReturnValue());
               component.set("v.items", items);
           }
       });
 
      
       
    },//addItem
   
    //server side action defined in CampingListController
    updateItem: function(component, item) {
        this.saveItem(component, item);
    },
 
    saveItem: function(component, expense, callback) {
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },//saveItem
 
   
 
    validateCampingItem: function(component, item) {
       
         // Simplistic error checking
        var validItem = true;
        console.log("validate item");
 
 
          // Name must not be blank
        var nameField = component.find("campItemName");
        var itemname = nameField.get("v.value");
        console.log("itemname="+itemname);
        if ($A.util.isEmpty(itemname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Item name can't be blank."}]);
        }
        else {
            console.log("good name "+itemname);
            nameField.set("v.errors", null);
        }
 
 
                              // Price must not be blank
        var priceField = component.find("price");
        var itemprice = priceField.get("v.value");
        console.log("itemprice="+itemprice);
       
        if (isNaN(itemprice)){
            validItem = false;
            priceField.set("v.errors", [{message:"Item price can't be null."}]);
        }
        else {
            priceField.set("v.errors", null);
        }
        if ($A.util.isEmpty(itemprice)){
            validItem = false;
            priceField.set("v.errors", [{message:"Item price can't be null."}]);
        }
        else {
            priceField.set("v.errors", null);
        }
       
        if (itemprice<0.01){
            validItem = false;
            priceField.set("v.errors", [{message:"Item price can't be zero."}]);
        }
        else {
            priceField.set("v.errors", null);
        }
 
 
        // Quantity must not be blank
        var qtyField = component.find("quantity");
        var itemqty = qtyField.get("v.value");
        console.log("itemqty ="+itemqty);
       
        console.log("now check empty"+qtyField);
        if (isNaN(itemqty)){
            console.log("bad qty ="+itemqty);
            validItem = false;
            qtyField.set("v.errors", [{message:"Item quantity can't be null."}]);
        }
        else {
            console.log("good");
            qtyField.set("v.errors", null);
        }
        if ($A.util.isEmpty(itemqty)){
            console.log("bad qty ="+itemqty);
            validItem = false;
            qtyField.set("v.errors", [{message:"Item quantity can't be null."}]);
        }
        else {
            console.log("good");
            qtyField.set("v.errors", null);
        }
        if (itemqty<1){
            console.log("bad qty <1 ="+itemqty);
            validItem = false;
            qtyField.set("v.errors", [{message:"Enter an Item quantity."}]);
        }
        else {
            console.log("good");
            qtyField.set("v.errors", null);
        }
       
     
        return(validItem);
       
    } //validateCampingItem
})