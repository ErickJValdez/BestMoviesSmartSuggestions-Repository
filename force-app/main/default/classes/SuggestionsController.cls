public with sharing class SuggestionsController {
    
    static string contactId = UserInfoController.getUserContactId();

    @AuraEnabled
    public static Boolean movieLike(Id movieId){
        Movie_Watch__c  movieWatch;

        try {
            movieWatch = [SELECT Id, Like__c FROM Movie_Watch__c WHERE Movie__c =: movieId AND Contact__c=:contactId LIMIT 1];
            movieWatch.Like__c = True;
            update movieWatch;

        } catch (Exception e) {
            System.debug('The following exception has occurred: ' + 
                            e.getMessage());
        }
        return movieWatch.Like__c;

    }

    @AuraEnabled
    public static Boolean movieDislike(Id movieId){
        Movie_Watch__c  movieWatch;

        try {
            movieWatch = [SELECT Id, Like__c FROM Movie_Watch__c WHERE Movie__c =: movieId AND Contact__c=:contactId LIMIT 1];
            movieWatch.Like__c = False;
            update movieWatch;

        } catch (Exception e) {
            System.debug('The following exception has occurred: ' + 
                            e.getMessage());
        }

        return movieWatch.Like__c;

    }

    @AuraEnabled
    public static Boolean checkMovieLike(Id movieId){
        Movie_Watch__c  movieWatch;

        try {
            movieWatch = [SELECT Id, Like__c FROM Movie_Watch__c WHERE Movie__c =: movieId AND Contact__c=:contactId LIMIT 1];

        } catch (Exception e) {
            System.debug('The following exception has occurred: ' + 
                            e.getMessage());
        }

        return movieWatch.Like__c;

    }


    public static Set<Id> genresMoviesUserLikes(){

        List<Category_Movie__c> genresOfMoviesLikesByUser = [SELECT Movie_Genre__c FROM Category_Movie__c WHERE Movie__c IN (SELECT Movie__c FROM Movie_Watch__c WHERE Contact__c =:contactId AND Like__c= True)];


        Set<Id> GenresId = new Set<Id>();
        
        for(Category_Movie__c listOfItem: genresOfMoviesLikesByUser) {
             if(listOfItem.Movie_Genre__c != Null) {
                GenresId.add(listOfItem.Movie_Genre__c);
                }
        }

            return GenresId;
    }


    public static string getUserMoviesRate(){

        Integer userAge = Integer.valueOf(UserInfoController.getUserContactAge());
        String queryUserMovies = '';

            if(userAge <= 13){
                queryUserMovies = 'AND (Rating__c = \'Rated G\' OR Rating__c = \'Rated PG\')';
            } else if(userAge < 30){
                 queryUserMovies ='AND (Rating__c = \'Rated G\' OR Rating__c = \'Rated PG\' OR Rating__c = \'Rated PG-13\')';
            }

            return queryUserMovies;
    }


    public static string getUserMoviesRateSuggestion(){

        Integer userAge = Integer.valueOf(UserInfoController.getUserContactAge());
        String queryUserMovies = '';

            if(userAge <= 13){
                queryUserMovies = 'AND (Movie__r.Rating__c = \'Rated G\' OR Movie__r.Rating__c = \'Rated PG\')';
            } else if(userAge < 30){
                 queryUserMovies ='AND (Movie__r.Rating__c = \'Rated G\' OR Movie__r.Rating__c = \'Rated PG\' OR Movie__r.Rating__c = \'Rated R\')';
            }

            return queryUserMovies;
    }


    public static Set<Id> likesMoviesByGenresForContact(){

        Set<Id> preferredGenre = SuggestionsController.genresMoviesUserLikes();
        String queryStringUserMovieSugg = SuggestionsController.getUserMoviesRateSuggestion();

        List<Category_Movie__c> preferredMoviesListOfUser = Database.query(
            'SELECT Movie__c FROM Category_Movie__c WHERE Movie_Genre__r.Id IN :preferredGenre '+queryStringUserMovieSugg+ ' ORDER BY Movie__r.Ranking__c DESC NULLS LAST, Movie__r.Global_Score__c DESC NULLS LAST LIMIT 10'
        );

        Set<Id> moviesId = new Set<Id>();

        for(Category_Movie__c listOfMovies: preferredMoviesListOfUser) {
            if(listOfMovies.Movie__c != Null) {
                moviesId.add(listOfMovies.Movie__c);
            }
        }

            return moviesId;
    }

    @AuraEnabled(cacheable=true)
    public static List<Movie__c> getMoviesSuggestion(){

        Set<Id> moviesIds= SuggestionsController.likesMoviesByGenresForContact();
        String queryStringUserTypeMovies = SuggestionsController.getUserMoviesRate();
        
        List<Movie__c> moviesList = Database.query(
            'SELECT Id, Name, Rating__c, Image_URL__c, Ranking__c, Global_Score__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c WHERE ID IN: moviesIds ORDER BY Ranking__c DESC NULLS LAST, Global_Score__c DESC NULLS LAST LIMIT 10'
            );
        
        Integer lists = moviesList.size();
        List<Movie__c> listres = new List<Movie__c>();
        Integer list2s = 10 - lists;
        listres.addAll(moviesList);
        if(lists < 10){
            List<Movie__c> bestMovies = Database.query(
                'SELECT Id, Name, Rating__c, Image_URL__c, Ranking__c, Global_Score__c, Trailer_URL__c, Short_Summary__c, Full_Summary__c FROM Movie__c WHERE ID NOT IN: moviesIds '+queryStringUserTypeMovies+' ORDER BY Ranking__c DESC NULLS LAST, Global_Score__c DESC NULLS LAST LIMIT :list2s'
                );

            listres.addAll(bestMovies);

        }    
            return listres;
    }


}