@isTest(SeeAllData=true)
public with sharing class MovieRankingControllerTest {
    
    @isTest static void testRunAsUserYoungAdultRanking() {
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
                          UserName=uniqueUserName);  //Adult User
        
        //Get a movie Id
        Movie__c m = [SELECT Id FROM Movie__c WHERE rating__c= 'Rated G' LIMIT 1];
        
        
        System.runAs(u) {
            // The following code runs as user 'u'
            
            
            System.assertEquals(False, MovieRankingController.checkIfWatchedMovie(m.Id));

            
            System.debug(MovieRankingController.createMovieWatchRecord(m.Id)); //To test all functionality
            
            
            System.assertEquals(True, MovieRankingController.checkIfWatchedMovie(m.Id));
            
            System.debug(MovieRankingController.checkIfRankedByUser(m.Id));
            
            String rank= MovieRankingController.rankMovie(m.Id, 4);
            
            System.debug(MovieRankingController.updateRankMovie(rank, 5));
            
        }
    }
}