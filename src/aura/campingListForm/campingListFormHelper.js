({
    validateCampingListForm: function(component) {
        var validItem = true;
        // Name must not be blank (aura id)
        var nameField = component.find("campItemName");
        console.log('nameField='+nameField+'<<<');
        var itemname = nameField.get("v.value");
        console.log('itemname='+itemname+'<<<');
        if ($A.util.isEmpty(itemname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Item name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
   
        // Quantity must be set, must be a positive number
        var amtField = component.find("quantity");
        console.log('qtyField='+amtField+'<<<');
        var amt = amtField.get("v.value");
        console.log('quantity='+amt+'<<<');
        if ($A.util.isEmpty(amt) || isNaN(amt) || (amt <= 0.0)){
            validItem = false;
            amtField.set("v.errors", [{message:"Enter an item quantity."}]);
        }
        else {
            // If the quantity looks good, unset any errors...
            amtField.set("v.errors", null);
        }
       
        //also do price
        //Price must be set, must be a positive number
        amtField = component.find("price");
        console.log('priceField='+amtField+'<<<');
        amt = amtField.get("v.value");
        console.log('price='+amt+'<<<');
        if ($A.util.isEmpty(amt) || isNaN(amt) || (amt <= 0.0)){
            validItem = false;
            amtField.set("v.errors", [{message:"Enter an item price."}]);
        }
        else {
            // If the price looks good, unset any errors...
            amtField.set("v.errors", null);
        }
        console.log('validItem='+validItem+'<<<');
        return(validItem);
       
    },//validateCampingListForm
   
    createItem: function(component, newItem) {
          
        console.log('in addItem');
        var newItem = component.get("v.newItem");
        var addEvent = component.getEvent("addItem");
        addEvent.setParams({"item" : newItem});
        addEvent.fire();
 
       
        //component.set("v.newItem", default);
        component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
    },//addItem
})