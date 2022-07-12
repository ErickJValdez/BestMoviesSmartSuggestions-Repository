public with sharing class CategoryMovieController {

    @AuraEnabled(cacheable=true)
    public static String movieGenres(Id movieId){
                           
        List<Category_Movie__c> movieCategories = [SELECT Movie_Genre__r.Name FROM Category_Movie__c WHERE Movie__c =: movieId];
        
        String movieGenres;
        
        for(Category_Movie__c listOfItem: movieCategories) {
             if(listOfItem.Movie_Genre__r.Name != Null) {
                movieGenres = listOfItem.Movie_Genre__r.Name +' ';
                }
        }

            return movieGenres;
    }



}