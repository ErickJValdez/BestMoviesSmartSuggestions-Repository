public with sharing class MovieRankingController {
    
     static String userContactId= UserInfoController.getUserContactId();


    @AuraEnabled(cacheable=true)
    public static Boolean checkIfWatchedMovie(Id movieId){

        List<Movie_Watch__c> movieWatch;
        try{
            movieWatch = Database.query('SELECT Id FROM Movie_Watch__c WHERE Contact__c =:userContactId AND Movie__c=:movieId LIMIT 1');
        } catch (Exception e){
          System.debug('An exception occurred: ' + e.getMessage());
        }

        if (movieWatch.isEmpty()) {
            return false;
        } else {
            return true;
        }

    }

    @AuraEnabled
    public static String createMovieWatchRecord(String movieId){

        MovieWatch movieWatchObject;
        Movie_Watch__c mw;

        try{
            movieWatchObject = (MovieWatch)JSON.deserialize(movieId, MovieWatch.class);

            mw = new Movie_Watch__c();
            mw.Movie__c = MovieWatchObject.movie;
            mw.Contact__c = userContactId;

            insert mw;
            
        } catch (DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }

        return String.valueOf(mw.Id);

    }

    //Wrapper class
    public class MovieWatch{
        @AuraEnabled
        public String movie;
      }
}
