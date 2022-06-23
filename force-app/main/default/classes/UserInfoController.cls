public with sharing class UserInfoController {

     
     public static String getUserContactId(){

        String loggedUserId = UserInfo.getUserId();

       //String loggedUserId = '0058c00000CfQQqAAN';
             User contact = Database.query(
          'SELECT ContactId FROM User WHERE Id =: loggedUserId LIMIT 1'
        );


        return String.valueOf(contact.ContactId);

    }

     public static String getUserContactAge(){

        String conId= UserInfoController.getUserContactId();
        Contact edad;

        if(String.isNotBlank(conId)){
            edad = Database.query(
                'SELECT Age__C FROM Contact WHERE Id =:conId LIMIT 1'
                );
        } else {
            edad = Database.query(
                'SELECT Age__C FROM Contact WHERE Id =\'0038c00002oTUK2AAO\'LIMIT 1'  //Just to test the System admin since it does not have a related contact.
                );
        }

        
        return String.valueOf(edad.Age__C);
    }

}