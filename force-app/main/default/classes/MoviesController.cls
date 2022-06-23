public with sharing class MoviesController {
   
    @AuraEnabled(cacheable=true)
    public static List<Movie__c> getMoviesSuggestion(){

        Set<Id> moviesIds= SuggestionsController.prefferedContactMoviesByGenres();
        String queryStringUserTypeMovies = SuggestionsController.getUserMoviesRate();
        
        List<Movie__c> moviesList = Database.query(
            'SELECT Id, Name, Rating__c, Image_URL__c, Ranking__c, Global_Score__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c WHERE ID IN: moviesIds '+queryStringUserTypeMovies+' ORDER BY Ranking__c DESC LIMIT 10'
            );
        
        Integer lists = moviesList.size();
        List<Movie__c> listres = new List<Movie__c>();
        Integer list2s = 10 - lists;
        listres.addAll(moviesList);
        if(lists < 10){
            List<Movie__c> bestMovies = Database.query(
                'SELECT Id, Name, Rating__c, Image_URL__c, Ranking__c, Global_Score__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c WHERE (ID NOT IN: moviesIds AND (RANKING__C  != NULL AND (RANKING__C > 0 OR Global_Score__c > 0))) '+queryStringUserTypeMovies+' ORDER BY Ranking__c DESC LIMIT :list2s'
                );

            listres.addAll(bestMovies);

                lists = lists + bestMovies.size();
                list2s = 10 - lists;
                
                If(lists<10) {
                    List<Movie__c> bMovies = Database.query(
                'SELECT Id, Name, Rating__c, Image_URL__c, Ranking__c, Global_Score__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c WHERE (RANKING__C  = NULL AND Global_Score__c > 0) '+queryStringUserTypeMovies+' ORDER BY Global_Score__c DESC LIMIT :list2s'
                );
                listres.addAll(bMovies);
                }

        }    
            return listres;
    }
        

}