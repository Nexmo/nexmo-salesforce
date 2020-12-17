@isTest
global class NexmoTest2 {
     /** version 1.2 - Don Mitchell - This will cover test methods and mock call outs.
     * */
    
    @isTest(SeeAllData=true)static void testCreds(){
        
        String smsChannel = 'sms';
        String messengerChannel = 'messenger';
        String viberChannel = 'viber_service_msg';
        String whatsappChannel = 'whatsapp';
        String mmsChannel = 'mms';
       
        System.assertEquals(smsChannel, Nexmo2.SMS_CHANNEL);
        System.assertEquals(messengerChannel, Nexmo2.MESSENGER_CHANNEL);
        System.assertEquals(viberChannel, Nexmo2.VIBER_CHANNEL);
        System.assertEquals(whatsappChannel, Nexmo2.WHATSAPP_CHANNEL);
        System.assertEquals(mmsChannel, Nexmo2.MMS_CHANNEL );
               
        String toId = '0123456789';//this is the contact number
        String fromId = '16123334567'; //this is the Nexmo number 
        String text = 'Test Message';
        String channel = 'sms';
        
        System.assertNotEquals(null, Nexmo2.buildRequestBody(toId, fromId, text, smsChannel));
        System.assertNotEquals(null, Nexmo2.buildRequestBody(toId, fromId, text, messengerChannel));
        System.assertNotEquals(null, Nexmo2.buildRequestBody(toId, fromId, text, viberChannel));
        System.assertNotEquals(null, Nexmo2.buildRequestBody(toId, fromId, text, whatsappChannel));
        System.assertNotEquals(null, Nexmo2.buildRequestBody(toId, fromId, text, mmsChannel));
        
    //    Nexmo.sendMessage(toId, fromId, text, channel);
    //    String authHeader = Nexmo.getAuthorizationHeader();
     //   Nexmo.sendMessageWithAuthheader(toId, fromId, text, channel);
        
        System.assertNotEquals(null, Nexmo2.getAuthorizationHeader());
        
        Test.setMock(HttpCalloutMock.class, new NexmoMock()); 
            HttpResponse response2 = Nexmo2.getResponse2();
           // HttpResponse response2 = Nexmo.getResponse();
            String contentType = response2.getHeader('Content-Type');
    		System.assert(contentType == 'application/json');
    		String actualValue = response2.getBody();
    		System.debug(response2.getBody());
    		String expectedValue = '{"request_id":"cc467e993b1f48018748","status":"02"}';
        
    		System.assertNotEquals(actualValue, expectedValue);
    		System.assertEquals(200, response2.getStatusCode());
    }      
    
    
    @isTest(SeeAllData=true) static void testNexmo(){

            Test.setMock(HttpCalloutMock.class, new NexmoMock()); 
            HttpResponse response = Nexmo2.getResponse();
           // HttpResponse response2 = Nexmo.getResponse();
            String contentType = response.getHeader('Content-Type');
    		System.assert(contentType == 'application/json');
    		String actualValue = response.getBody();
    		System.debug(response.getBody());
    		String expectedValue = '{"request_id":"cc467e993b1f48018748","status":"0"}';
        
    		System.assertEquals(actualValue, expectedValue);
    		System.assertEquals(200, response.getStatusCode());
    }
}