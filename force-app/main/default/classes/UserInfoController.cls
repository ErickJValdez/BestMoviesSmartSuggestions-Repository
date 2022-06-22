public with sharing class UserInfoController {

     
     public static String getUserContactId(){

        String loggedUserId = UserInfo.getUserId();

       // String loggedUserId = '0058c00000CfQQqAAN';

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
                'SELECT Age__C FROM Contact WHERE Id =\'0038c00002oTUK2AAO\'LIMIT 1'  //Just to test the System admin since it does not have a related user.
                );
        }

        
        return String.valueOf(edad.Age__C);
    }

    public static string getUserMoviesRate(){

        Integer userAge = Integer.valueOf(UserInfoController.getUserContactAge());
        String queryUserMovies = '';

            if(userAge <= 13){
                queryUserMovies = '(Rating__c = \'Rated G\' OR Rating__c = \'Rated PG\')';
            } else if(userAge < 30){
                 queryUserMovies ='(Rating__c = \'Rated G\' OR Rating__c = \'Rated PG\' OR Rating__c = \'Rated R\')';
            }

            return queryUserMovies;
    }


}