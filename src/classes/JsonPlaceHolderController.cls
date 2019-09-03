public with sharing class JsonPlaceHolderController {
    private static final String ENDPOINT = 'JSONPlaceHolder';

    @AuraEnabled
    public static List<JsonImage> getAllImages(){
        HTTPRequest httpRequest = new httpRequest();
        httpRequest.setMethod('GET');
        httpRequest.setHeader('Content-Type','application/json');
        httpRequest.setEndpoint('callout:' + ENDPOINT+'/photos/');
        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);
     
        List<JsonImage> images = (List<JsonImage>)JSON.deserialize(httpResponse.getBody(), List<JsonImage>.class);
        List<JsonImage> lessImages = new List<JsonImage>();
        
        integer i = 100;
        while(i>0){
            lessImages.add(images.get(i));
            i--;
        }
        
        return lessImages;
    }
    
    public static void updateImageResources(List<ImageResource__c> itemToDelete){
        List<JsonImage> images = getAllImages();
        List<ImageResource__c> resources = new List<ImageResource__c>();
        
        delete itemToDelete;
        
        for(JsonImage img : images){
            ImageResource__c resource = new ImageResource__c();
            resource.Id__c = Decimal.valueOf(img.id);
            resource.Album_Id__c = Decimal.valueOf(img.albumId);
            resource.ThumbnailUrl__c = img.thumbnailUrl;
            resource.Title__c = img.title;
            resource.Url__c = img.url;
            resources.add(resource);
        }
        insert resources;
    }
    
    public static void insertFile(HttpResponse httpResponse ){
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; 
        conVer.PathOnClient = 'myJSON.json';
        conVer.Title = 'Images ';
        conVer.VersionData = Blob.valueOf(httpResponse.getBody());
        insert conVer;
    }
        
    @AuraEnabled
    public static List<ImageResource__c> getFilteredImages(String namefilter){
        String filterValue = '%'+namefilter+'%';        
        System.debug('filterValue'+filterValue);
        List<ImageResource__c> resources = [SELECT Id__c,Album_Id__c, ThumbnailUrl__c, Title__c, Url__c 
                                            FROM ImageResource__c WHERE Title__c LIKE :filterValue ];
        return resources;
    }
    
    @AuraEnabled
    public static void sendEmailWithResults(String messageBody) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'patryk.kosinski@gmail.com' };
        message.optOutPolicy = 'FILTER';
        message.subject = 'Filter results in picture gallery';
        message.plainTextBody = messageBody;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
}