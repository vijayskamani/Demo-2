({
    handleAddItem: function(component, event, helper) {
        var newItem = event.getParam("item");
        helper.addItem(component, newItem);
    },
 
    clickcreateitem: function(component, event, helper) {
        console.log('submit if valid');
        var nameField = component.find("campItemName");
        console.log('nameField='+nameField+'<<<');
        var itemname = nameField.get("v.value");
        console.log('itemname='+itemname+'<<<');
        console.log('submit if valid...');
       
        if(helper.validateCampingListForm(component)){
            console.log('valid so add');
            // Add the new item
            //var newItem = component.get("v.newItem"); //created in helper
            //helper.addItem(component, newItem);
            helper.createItem(component);
        }
    },
 
})