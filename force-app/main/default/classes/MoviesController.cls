public with sharing class MoviesController {
   
    @AuraEnabled(cacheable=true)
    public static List<Movie__c> getMoviesSuggestion(){
        Set<Id> moviesIds= SuggestionsController.prefferedContactMoviesByGenres();


        List<Movie__c> moviesList = Database.query(
            'SELECT Id, Name, Rating__c, Image_URL__c, Ranking__c, Global_Score__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c WHERE (ID IN: moviesIds OR Ranking__c > 2) LIMIT 10'
            );
            
            return moviesList;
    }
}