public with sharing class MoviesSearchBarController {
    
    @AuraEnabled(cacheable=true)
    public static List<Movie__c> displayMovieRecords(String seachkey){
        String searchword = '%'+seachkey+'%';

        System.debug('===searchWord==='+searchword);

        List<Movie__c> movList = new List<Movie__c>();

        for(Movie__c mov:[select Name from Movie__c where Name=:searchword]){
            movList.add(mov);

        }
        return movList;

    }
}
