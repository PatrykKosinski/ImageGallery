public with sharing class JsonImage {
    
    @AuraEnabled
    public String albumId{get; set;}
    @AuraEnabled
    public String id{get; set;}
    @AuraEnabled
    public String title{get; set;}
    @AuraEnabled
    public String url{get; set;}
    @AuraEnabled
    public String thumbnailUrl{get; set;}
    
}