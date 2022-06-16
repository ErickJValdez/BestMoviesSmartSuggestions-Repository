public with sharing class MoviesSearchBarController {
    
    @AuraEnabled(cacheable=true)
    public static List<Movie__c> displayMovieRecords(String seachkey){
        String searchword = '%'+seachkey+'%';
        System.debuf('===searchWord==='+searchword);
        List<Movie__c> movList = new List<Movie__c>();
        for(Movie__c mov:[select MovieTitle from Movie__c where MovieTitle=:searchword]){
            movList.add(mov);

        }
        return movList;

    }
}
