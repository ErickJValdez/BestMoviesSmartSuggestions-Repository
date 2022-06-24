public with sharing class MoviesSearchBarController {
    
    @AuraEnabled(cacheable=true scope='global')
    public static List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {
        // Prepare query parameters
        searchTerm = '%' + searchTerm + '%';
        // Execute search query
        List<Movie__c> entries = [
            SELECT Name
            FROM Movie__c
            WHERE
                Name LIKE :searchTerm
                AND Id NOT IN :selectedIds
            LIMIT 5
        ];
        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        for (Movie__c entry : entries) {
            results.add(new LookupSearchResult(entry.Id, null, null, entry.Name, null));
        }
        return results;
   
}

}
