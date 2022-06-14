
public with sharing class UserInfoController {

        String loggedUserId = UserInfo.getUserId();

     public static String getUserContactId(){
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


        public UserInfoController() {

    }
}
