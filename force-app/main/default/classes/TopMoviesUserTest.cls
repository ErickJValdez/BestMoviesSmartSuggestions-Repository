@isTest(SeeAllData=true)

public class TopMoviesUserTest {
    
    @isTest static void topMoviesTest(){
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
         Movie__c movie = [SELECT Id FROM Movie__c LIMIT 1];
         System.assertEquals(10, TopMoviesUser.getDefaultMovies().size());
        
        System.runAs(u){
            System.debug(TopMoviesUser.getYoungMovies());
            System.assertEquals(10,TopMoviesUser.getYoungMovies().size());
            System.assertEquals(53,TopMoviesUser.getAllYoungMovies(53, 1).size());
        }
        
         System.runAs(u2){
            System.debug(TopMoviesUser.getChildMovies());
            System.assertEquals(10,TopMoviesUser.getChildMovies().size());
            System.assertEquals(12,TopMoviesUser.getAllChildMovies(12, 1).size());
        }
        
         System.runAs(u3){
            System.debug(TopMoviesUser.getAdultMovies());
            System.assertEquals(10,TopMoviesUser.getAdultMovies().size());
            System.assertEquals(72,TopMoviesUser.getAllAdultMovies(72, 1).size());
        }    
        
        
    }


}