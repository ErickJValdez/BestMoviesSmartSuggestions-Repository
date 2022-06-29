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
    public static String createMovieWatchRecord(Id movieId){

        Movie_Watch__c mw;
        try{
          
            mw = new Movie_Watch__c();
            mw.Movie__c = movieId;
            mw.Contact__c = userContactId;
            insert mw;
            
        } catch (DmlException e){
            System.debug('The following exception has occurred: ' + 
                            e.getMessage());
        }
        return String.valueOf(mw.Id);

    }

    @AuraEnabled(cacheable=true)
    public static Customer_Ranking__c checkIfRankedByUser(Id movieId){

        Customer_Ranking__c movieRanked;
        try{
            movieRanked = Database.query('SELECT Id, Rank__c FROM Customer_Ranking__c WHERE Contact__c =:userContactId AND Movie__c=:movieId LIMIT 1');
        } catch (Exception e){
          System.debug('An exception occurred: ' + e.getMessage());
        }
        
            return movieRanked;

    }

    @AuraEnabled
    public static String rankMovie(Id movieId, Integer rankNumber){

        Customer_Ranking__c cr;
        try{
          
            cr = new Customer_Ranking__c();
            cr.Movie__c = movieId;
            cr.Contact__c = userContactId;
            cr.Rank__c = rankNumber;

            insert cr;
            
        } catch (DmlException e){
            System.debug('The following exception has occurred: ' + 
                            e.getMessage());
        }
        return String.valueOf(cr.Id);

    }

    @AuraEnabled
    public static String updateRankMovie(Id rankId, Integer rankNumber){
        Customer_Ranking__c  movieRankToUp;

        try {
            movieRankToUp = [SELECT Id, Rank__c FROM Customer_Ranking__c WHERE ID =: rankId LIMIT 1];
            movieRankToUp.Rank__c = rankNumber;
            update movieRankToUp;

        } catch (Exception e) {
            System.debug('The following exception has occurred: ' + 
                            e.getMessage());
        }

        return String.valueOf(movieRankToUp.Id);

    }


   



}
