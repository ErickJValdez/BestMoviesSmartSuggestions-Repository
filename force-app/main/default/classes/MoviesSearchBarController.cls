public with sharing class MoviesSearchBarController {
    
    @AuraEnabled(cacheable=true scope='global')
    public static List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {
        // Prepare query parameters
        searchTerm = '%' + searchTerm + '%';
        // Execute search query
        List<Movie__c> entries = [
            SELECT Name,
                Image_URL__c,
                Rating__c,
                Global_Score__c,
                Ranking__c,
                Full_Summary__c
            FROM Movie__c
            WHERE
                Name LIKE :searchTerm
                AND Rating__c IN : getUserRating()
                AND Id NOT IN :selectedIds
            LIMIT 5
        ];
        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        for (Movie__c entry : entries) {
            results.add(new LookupSearchResult(entry.Id, 'Movie__c', 'custom:custom24', entry.Name, null, entry));
        }
        return results;
    }

    private static Set<String> getUserRating() {
        Integer userAge = Integer.valueof(UserInfoController.getUserContactAge());
        Set<String> ratingSet = new Set<String>();

        ratingSet.add('Rated G');
        ratingSet.add('Rated PG');



        if(userAge > 14) {
            ratingSet.add('Rated PG-13');
        }

        if(userAge >= 30) {
            ratingSet.add('Rated R');
        }

        return ratingSet;
    }
    
    @AuraEnabled
    public static String test() {
        String test = '';	
        
        for(String rating : getUserRating()) {
			test = test + ' ' + rating;             
        }
        
        return test;
    }
}