
public with sharing class SuggestionsController {
    
    //public static string contactId = UserInfoController.getUserContactId();


    public static Set<Id> prefferedContactGenres(){
        
        String contactId = UserInfoController.getUserContactId();
                   
        List<Preferred_Genres__c> preferredGenresListOfUser = [SELECT Movie_Genre__c FROM Preferred_Genres__c WHERE Contact__c =: contactId];
        
        Set<Id> preferredGenresId = new Set<Id>();
        
        for(Preferred_Genres__c listOfItem: preferredGenresListOfUser) {
             if(listOfItem.Movie_Genre__c != Null) {
                preferredGenresId.add(listOfItem.Movie_Genre__c);
                }
        }

            return preferredGenresId;
    }


    public static Set<Id> prefferedContactMoviesByGenres(){

        Set<Id> preferredGenre = SuggestionsController.prefferedContactGenres();
        
        List<Category_Movie__c> preferredMoviesListOfUser = Database.query(
            'SELECT Movie__c FROM Category_Movie__c WHERE Movie_Genre__r.Id IN :preferredGenre ORDER BY Movie__r.Ranking__c LIMIT 10'
        );

        Set<Id> moviesId = new Set<Id>();

        for(Category_Movie__c listOfMovies: preferredMoviesListOfUser) {
            if(listOfMovies.Movie__c != Null) {
                moviesId.add(listOfMovies.Movie__c);
            }
        }

            return moviesId;
    }



}
