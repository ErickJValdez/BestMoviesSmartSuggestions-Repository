public with sharing class TrendingController {

    @AuraEnabled(cacheable=true) 
    public static List<Movie__c> getTrendMovies(){
        List<Movie__c> movies = [SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c 
                                FROM Movie__c WHERE Id IN (SELECT Movie__c FROM Movie_Watch__c) 
                                    AND Rating__c IN : getUserRating()];
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
    private static Set<String> getUserRating() {
        Integer userAge = Integer.valueof(UserInfoController.getUserContactAge());
        Set<String> ratingSet = new Set<String>();

        ratingSet.add('Rated G');
        ratingSet.add('Rated PG');



        if(userAge > 13) {
            ratingSet.add('Rated PG-13');
        }

        if(userAge >= 30) {
            ratingSet.add('Rated R');
        }

        return ratingSet;
    }
    
}
