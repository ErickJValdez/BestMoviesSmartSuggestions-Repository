public with sharing class TrendingController {
    public static List<Movie__c> getDefaultMovies(){
        List<Movie__c> movies = [SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Ranking__c > 3.8 order by Ranking__c DESC LIMIT 10];
        Integer listsize = movies.size();
        List<Movie__c> result = new List<Movie__c>();
        Integer listsize2 = 10 - listsize;
        result.addAll(movies);
        if(listsize < 10){
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Full_Summary__c FROM Movie__c where Global_Score__c > 5 AND Ranking__c = NULL order by Global_Score__c DESC LIMIT :listsize2';
                List<Movie__c> watchedMovies = Database.query(query);
                result.addAll(watchedMovies);
        }
        return result;
}
}