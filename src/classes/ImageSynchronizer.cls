global class ImageSynchronizer implements Database.Batchable<sObject>, Schedulable,Database.Stateful, Database.AllowsCallouts{
    global void execute(System.SchedulableContext sc){    
        ImageSynchronizer imageSynchronizer = new ImageSynchronizer();
        database.executeBatch(imageSynchronizer);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM ImageResource__c' ;
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<ImageResource__c> imageResources) {
        JsonPlaceHolderController.updateImageResources(imageResources);
    }
    
    global void finish(Database.BatchableContext BC) {
    }
}