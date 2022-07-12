@isTest(SeeAllData=true)

public class allMoviesControllerTest {
    @isTest static void allMoviesTest(){
        //Unique username
        String user = 'username' + DateTime.now().getTime() + '@testorg.com';
        //Child Contact
        Contact cont = new Contact(LastName = 'Movie Young user', AccountId = '0018c00002M2FSKAA3', Birthdate = Date.valueOf('1995-3-17'));
        insert cont;
        Profile p = [SELECT Id FROM Profile WHERE Name='Movie User'];
        User u = new User(Alias = 'movieUs', Email='standarduser@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles', Birthday__c =Date.valueOf('1985-4-24'), ContactId= cont.Id,
                          UserName=user);
        
        User u2 = [SELECT Id FROM User WHERE UserName='marie.j@gmail.com']; //Child user
        
        User u3 = [SELECT Id FROM User WHERE UserName='danelane@grayejvv13062022gmail.com']; //Adult User 
        
        //Movie
         Movie__c movie = [SELECT Id FROM Movie__c WHERE Rating__c= 'Rated PG' LIMIT 1];
        
        System.runAs(u){
            System.debug(allMoviesController.getAllMovies(10, 54));
        }
        
         System.runAs(u2){
            System.debug(allMoviesController.getAllMovies(10, 13));
        }
        
         System.runAs(u3){
            System.debug(allMoviesController.getAllMovies(10, 73));
        }    
        
        
    }

}