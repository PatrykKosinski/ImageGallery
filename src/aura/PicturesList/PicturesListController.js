({
    getAllPictures : function(component, event, helper) {
        helper.setImages(component);    
    },
    getfilteredPictures : function(component, event, helper) {
        helper.setFilteredImages(component);    
    },
    sendEmail : function(component, event, helper) {
        helper.sendEmailResults(component);
    },
    next: function (component, event, helper) {
        helper.nextPage(component);        
    },
    previous: function (component, event, helper) {
        helper.previousePage(component);
    }
})