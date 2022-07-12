@isTest(SeeAllData=true)
public class UserInfoControllerTest {
    @isTest static void userContactIdSysAdmin() {
        String contactId = UserInfoController.getUserContactId();
                System.assertEquals('0038c00002oSEkzAAG',contactId);        
    }
    
    @isTest static void testRunAsUser() {
        // Setup test data
        // 
        // Create a unique UserName
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        // 
        // Create Related Contact
      	Contact c = new Contact (LastName = 'Movie User', AccountId  = '0018c00002M2FSKAA3', Birthdate= Date.valueOf('2000-4-24'));
        insert c;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Movie User'];
        User u = new User(Alias = 'movieUs', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles', Birthday__c =Date.valueOf('2000-4-24'), ContactId= c.Id,
         UserName=uniqueUserName);   
         
        
        User u2 = [SELECT Id FROM User WHERE UserName='marie.j@gmail.com'];


        System.runAs(u) {
            
              // The following code runs as user 'u'
              System.debug('Current User: ' + UserInfoController.getUserContactId());
              System.debug('Current Profile: ' + UserInfoController.getUserContactAge());
          }
        
         System.runAs(u2) {
            
              // The following code runs as user 'u'
              System.debug('Current User: ' + UserInfoController.getUserContactId());
              System.debug('Current Profile: ' + UserInfoController.getUserContactAge());
          }
    }
    
    
}