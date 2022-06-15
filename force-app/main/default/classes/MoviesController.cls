public with sharing class MoviesController {
   
    @AuraEnabled(cacheable=true)

    public static List<Movie__c> getMovies(){
        List<Movie__c> moviesList = Database.query(
            'SELECT Id, Name, Rating__c, Image_URL__c, Global_Score__c, Ranking__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c LIMIT 10'
            );
            

            return moviesList;


    }
}
