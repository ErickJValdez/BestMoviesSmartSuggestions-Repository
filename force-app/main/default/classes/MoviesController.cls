public with sharing class MoviesController {
   
    @AuraEnabled(cacheable=true)

    public static List<Movie__c> getMovies(){
        List<Movie__c> moviesList = Database.query(
            'SELECT Id, Name, Rating__c, Image_URL__c, Global_Score__c, Ranking__c FROM Movie__c LIMIT 15'
            );
            

            return moviesList;


    }
}
