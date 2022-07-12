public with sharing class TrendingController {

    @AuraEnabled(cacheable=true)

    public static List<Movie__c> getTrendMovies(){
        List<Movie__c> movies = [SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c];
        Integer listsize = movies.size();
        List<Movie__c> result = new List<Movie__c>();
        Integer listsize2 = 10 - listsize;
        result.addAll(movies);
        if(listsize < 10){
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Full_Summary__c FROM Movie__c';
                List<Movie__c> trendMovies = Database.query(query);
                result.addAll(trendMovies);
        }
        return result;

    }
}