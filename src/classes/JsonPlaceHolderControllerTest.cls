@isTest
public class JsonPlaceHolderControllerTest {
    private static String TEST_VALUE = 'TEST';
    
    @isTest
    public static void getAllImagesTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        List<JsonImage> imagesFromResponse = JsonPlaceHolderController.getAllImages();
        Test.stopTest();
        
        System.assertEquals(1, imagesFromResponse.size());
        System.assertEquals('1', imagesFromResponse.get(0).albumId);
        System.assertEquals('1', imagesFromResponse.get(0).id);
        System.assertEquals(TEST_VALUE, imagesFromResponse.get(0).title);
        System.assertEquals(TEST_VALUE, imagesFromResponse.get(0).url);
        System.assertEquals(TEST_VALUE, imagesFromResponse.get(0).thumbnailUrl);
    }
    
    @isTest
    public static void updateImageResourcesTest(){        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        ImageResource__c testImage = new ImageResource__c();
        testImage.Id__c = 1;
        testImage.Title__c = TEST_VALUE;
        testImage.ThumbnailUrl__c = TEST_VALUE;
        testImage.Url__c = TEST_VALUE;
        
        List<ImageResource__c> testImages = new List<ImageResource__c>();
        testImages.add(testImage);
        
        insert testImages;
        
        Test.startTest();
        JsonPlaceHolderController.updateImageResources(testImages);
        Test.stopTest();
        
        List<ImageResource__c> imagesAfterUpdate = [SELECT Id__c, Album_Id__c, ThumbnailUrl__c, Title__c, Url__c 
                                                    FROM ImageResource__c];
        System.assertEquals(1, imagesAfterUpdate.size());
        System.assertEquals(1, imagesAfterUpdate.get(0).Album_Id__c);
        System.assertEquals(1, imagesAfterUpdate.get(0).Id__c);
        System.assertEquals(TEST_VALUE, imagesAfterUpdate.get(0).Title__c);
        System.assertEquals(TEST_VALUE, imagesAfterUpdate.get(0).ThumbnailUrl__c);
        System.assertEquals(TEST_VALUE, imagesAfterUpdate.get(0).Url__c);
    }
    
    @isTest
    public static void getFilteredImagesTest(){
        ImageResource__c testImage = new ImageResource__c();
        testImage.Id__c = 1;
        testImage.Album_Id__c = 1;
        testImage.Title__c = TEST_VALUE;
        testImage.ThumbnailUrl__c = TEST_VALUE;
        testImage.Url__c = TEST_VALUE;
        
        insert testImage;
        Test.startTest();
        List<ImageResource__c> filteredImages = JsonPlaceHolderController.getFilteredImages(TEST_VALUE);
        JsonPlaceHolderController.sendEmailWithResults(TEST_VALUE);
        Test.stopTest();
        
        System.assertEquals(1, filteredImages.size());
        System.assertEquals(1, filteredImages.get(0).Album_Id__c);
        System.assertEquals(1, filteredImages.get(0).Id__c);
        System.assertEquals(TEST_VALUE, filteredImages.get(0).Title__c);
        System.assertEquals(TEST_VALUE, filteredImages.get(0).ThumbnailUrl__c);
        System.assertEquals(TEST_VALUE, filteredImages.get(0).Url__c);
    }
}