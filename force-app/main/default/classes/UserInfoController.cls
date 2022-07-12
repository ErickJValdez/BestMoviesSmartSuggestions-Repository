public with sharing class UserInfoController{
    
    public static String getUserContactId(){

        String loggedUserId = UserInfo.getUserId();
        User contact;

        try{
            contact = Database.query('SELECT ContactId FROM User WHERE Id =: loggedUserId LIMIT 1');
        } catch (Exception e){
            System.debug('An exception occurred: ' + e.getMessage());
        }

        if(contact.ContactId!=null){
            return String.valueOf(contact.ContactId);
        } else {
            return '0038c00002oSEkzAAG'; // Sys admin related contact for testing purpose!
        }

       
    }

    public static String getUserContactAge(){

        String conId = UserInfoController.getUserContactId();
        Contact edad;

        if (String.isNotBlank(conId)){
                edad = [SELECT Age__C FROM Contact WHERE Id =:conId LIMIT 1];
       }

        return String.valueOf(edad.Age__C);
    }

}