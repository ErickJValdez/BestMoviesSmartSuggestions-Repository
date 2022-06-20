public with sharing class UserInfoController {


     
     public static String getUserContactId(){

        String loggedUserId = UserInfo.getUserId();

             User contact = Database.query(
          'SELECT ContactId FROM User WHERE Id =: loggedUserId LIMIT 1'
        );

        return String.valueOf(contact.ContactId);

    }

     public static String getUserContactAge(){

        String conId= UserInfoController.getUserContactId();
        
        Contact edad = Database.query(
         'SELECT Age__C FROM Contact WHERE Id =:conId LIMIT 1'
         );

        return String.valueOf(edad.Age__C);
    }


}