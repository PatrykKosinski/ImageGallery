@isTest
public class ImageSynchronizerTest {
    private static String TEST_VALUE = 'TEST';
    
    @isTest
    public static void synchonizeImageResourcesTest(){
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
        ImageSynchronizer synchronizer = new ImageSynchronizer();
        Database.executeBatch(synchronizer);
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
    
}