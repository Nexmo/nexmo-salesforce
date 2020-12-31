@isTest
global class NexmoConfigContMock implements HttpCalloutMock{
    
     global HTTPResponse respond(HTTPRequest req) {
      
        System.assertEquals('https://api.nexmo.com/v0.1/messages', req.getEndpoint()); 
        System.assertEquals('POST', req.getMethod()); 
         
        // Create a fake response 
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type','application/json');
        response.setBody('{"request_id":"cc467e993b1f48018748","status":"0"}');
        response.setStatusCode(400);
        response.setStatus('Bad Request');   
                
        return response; 
    }

}