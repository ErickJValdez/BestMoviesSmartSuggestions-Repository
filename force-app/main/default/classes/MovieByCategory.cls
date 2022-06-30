/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-30-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class MovieByCategory {
    @AuraEnabled(cacheable=true)
    public static List<Movie__c> getMovies(String categoryId){
        String age = UserInfoController.getUserContactAge();
        List<Movie__c> childresult = new List<Movie__c>();
        List<Movie__c> youngresult = new List<Movie__c>();
        List<Movie__c> adultresult = new List<Movie__c>();
        if(Integer.valueOf(age) <= 13){
            childresult.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Id IN (SELECT Movie__c FROM Category_Movie__c WHERE Movie_Genre__c = :categoryId) AND (Rating__c = 'Rated G' OR Rating__c = 'Rated PG')]);
            return childresult;
        }
        else if(Integer.valueOf(age) <= 30){
            youngresult.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Id IN (SELECT Movie__c FROM Category_Movie__c WHERE Movie_Genre__c = :categoryId) AND (Rating__c = 'Rated G' OR Rating__c = 'Rated PG' OR Rating__c = 'Rated PG-13')]);
            return youngresult;
        }
        else if(Integer.valueOf(age) > 30){
            adultresult.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Id IN (SELECT Movie__c FROM Category_Movie__c WHERE Movie_Genre__c = :categoryId)]);
            return adultresult;
        }
        List<Movie__c> movieList = [SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Id IN (SELECT Movie__c FROM Category_Movie__c WHERE Movie_Genre__c = :categoryId)];
        return movieList;
    }
}
    
