@isTest(seeAllData=true)
public with sharing class NexmoConfigurationControllerTest {
  
 
    public static testMethod void testController(){
              
        NexmoConfig__c conf = new NexmoConfig__c();
        conf.Name = 'Nexmo';
        conf.API_Key__c = '123456789';
        conf.API_Secret__c = '123456789qawsedrf123456789';
        //insert conf;
 
        NexmoConfigurationController nexmoConfCtrl = new NexmoConfigurationController();
        System.assertNotEquals('123456789', nexmoConfCtrl.apiKey);
        System.assertNotEquals('123456789qawsedrf123456789', nexmoConfCtrl.apiSecret);
        //System.assertNotEquals(null, nexmoConfCtrl.virtualPhoneNumber);
        
        String apiKey = 'QWERTY';
        String apiSecret = '12345QWERTY';
        String virtualNumber = '12165551212';
        Blob auth = Blob.valueOf(apiKey + ':' + apiSecret);
        String headerValue = 'BASIC ' + EncodingUtil.base64Encode(auth);
        
//version 2.0 dgm - new testcode with Test HttpResponse Mock file
        
            Test.setMock(HttpCalloutMock.class, new NexmoConfigContMock());         

            HttpResponse response = NexmoConfigurationController.WebCallAuth(apiKey, apiSecret, virtualNumber); 
            String contentType = response.getHeader('Content-Type');
    		System.assert(contentType == 'application/json');
          //  String Authorization = response.getHeader('Authorization');
          //  System.assert(Authorization != 'BASIC' + apiKey +':'+ apiSecret);
    		String actualValue = response.getBody();
    		System.debug(response.getBody());
    	    String expectedValue = '{"Status":Bad Request", "StatusCode":400}';
            System.assertEquals(400, response.getStatusCode());
      
        
    }
}