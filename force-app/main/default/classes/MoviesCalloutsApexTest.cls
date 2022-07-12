@isTest(SeeAllData=true)
public class MoviesCalloutsApexTest {
    
    private static final String FAKE_RESPONSE_JSON = 'This is a test response';

    public class Mock implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {

            // You could assert the request content here
				
            System.assertEquals('GET', req.getMethod());
            
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"imdbRating":"9"},{"Poster":"https://m.media-amazon.com/images/I/A1-W2j6pPZL._SL1500_.jpg"}');
            
            res.setStatusCode(200);
            return res;
        }
    }
    
    @isTest static void testBatchClass(){
       
        //Get movie info to test
        //
        List<movie__c> movies = [SELECT Id, Name FROM Movie__c];
        
        Test.setMock(HttpCalloutMock.class, new Mock());
        
        MoviesCalloutsBatchApex bs = new MoviesCalloutsBatchApex();

        Test.startTest();
        	database.executeBatch(bs,100);
        Test.stopTest();
    }
    
    @isTest static void testScheduleClass() {        
        Test.startTest();
         MoviesScoreSchedule myClass = new MoviesScoreSchedule ();   
         String chron = '0 0 23 * * ?';        
         system.schedule('Test Schedule', chron, myClass);
        Test.stopTest();
    }


}