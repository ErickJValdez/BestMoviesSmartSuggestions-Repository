/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-30-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class allMoviesController {
        @AuraEnabled(cacheable=true)

    public static List<Movie__c> getAllMovies(){
        
        List<Movie__c> childresult = TopMoviesUser.getAllChildMovies();
        List<Movie__c> youngresult = TopMoviesUser.getAllYoungMovies();
        List<Movie__c> adulresult = TopMoviesUser.getAllAdultMovies();
        List<Movie__c> movies = TopMoviesUser.getDefaultMovies();
        String age = UserInfoController.getUserContactAge();
            if(Integer.valueOf(age) <= 13){
                return childresult;
            }
            else if(Integer.valueOf(age) <= 30){
                return youngresult;
            }
            else if(Integer.valueOf(age) > 30){
                return adulresult;
            }
            else{
                return movies;
            }

        
        
    }

    
}
