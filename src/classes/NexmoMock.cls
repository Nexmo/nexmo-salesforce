@isTest
global class NexmoMock implements HttpCalloutMock{
     // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type','application/json');
        response.setBody('{"request_id":"cc467e993b1f48018748","status":"0"}');
        response.setStatusCode(200);
        response.setStatus('13');   
      
        JSONParser parser = JSON.createParser(response.getBody());
        string requestID ='';
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'request_id')) {
                    parser.nextToken();
                    requestID += parser.getText();
                }
        }
                
        return response; 
    }

}