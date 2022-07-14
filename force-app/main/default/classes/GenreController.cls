/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-14-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class GenreController {
    @AuraEnabled(cacheable=true)
    public static List<Movie_Genre__c> getMovieGenres(){
        List<Movie_Genre__c> genreList = [SELECT Name, Id FROM Movie_Genre__c ORDER BY Name];
        return genreList;
    }
}