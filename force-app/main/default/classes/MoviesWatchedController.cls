public with sharing class MoviesWatchedController {
    

    public static Boolean  movieWatched(String MovieID){
        
        String contactId = UserInfoController.getUserContactId();
                   
        List<Movie_Watch__c> movieWatchedVar = [SELECT Id, Movie__c, Contact__c FROM Movie_Watch__c WHERE Contact__c =: contactId AND Movie__c =:MovieID LIMIT 1];
        
        if(movieWatchedVar.IsEmpty()){
            return false;
        } else {
            return true;
        }    
    }

    



}
