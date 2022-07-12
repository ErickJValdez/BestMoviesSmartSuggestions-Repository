@isTest(SeeAllData=true)
public class SuggestionsControllerTest {
    
    @isTest static void testRunAsUserYoungAdultSuggestions() {
        // Setup test data
        // 
        // Create a unique UserName
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        // 
        // Create Related Contact
        Contact c = new Contact (LastName = 'Movie User', AccountId  = '0018c00002M2FSKAA3', Birthdate= Date.valueOf('1985-4-24'));
        insert c;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Movie User'];
        User u = new User(Alias = 'movieUs', Email='standarduser@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles', Birthday__c =Date.valueOf('1985-4-24'), ContactId= c.Id,
                          UserName=uniqueUserName);
        
        User u2 = [SELECT Id FROM User WHERE UserName='marie.j@gmail.com']; //Child User
        
        User u3 = [SELECT Id FROM User WHERE UserName='JaneRoss@grayejvvg10062022gmail.com']; //Young Adult User
        
                    //Get a movie Id
    Movie__c m = [SELECT Id FROM Movie__c WHERE rating__c= 'Rated G' LIMIT 1];

        
        System.runAs(u) {
            // The following code runs as user 'u'

            System.debug(MovieRankingController.createMovieWatchRecord(m.Id)); //To test all functionality

         
  			System.assertEquals(True, SuggestionsController.movieLike(m.Id));
            System.assertEquals(True, SuggestionsController.checkMovieLike(m.Id));
            System.assertEquals(False, SuggestionsController.movieDislike(m.Id));

            
            
            System.debug(SuggestionsController.getMoviesSuggestion());
            System.assertEquals(10, SuggestionsController.getMoviesSuggestion().size());        
        }
        
        System.runAs(u2) {
            
            // The following code runs as user 'u2'
            
            System.debug(SuggestionsController.getMoviesSuggestion());
            System.assertEquals(10, SuggestionsController.getMoviesSuggestion().size());        
        }
        
         System.runAs(u3) {
            
            // The following code runs as user 'u3'
            
            System.debug(SuggestionsController.getMoviesSuggestion());
            System.assertEquals(10, SuggestionsController.getMoviesSuggestion().size());        
        }
        
        
    }
    
}