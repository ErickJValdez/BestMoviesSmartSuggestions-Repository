
public with sharing class SuggestionsController {
    
    public static string contactId = UserInfoController.getUserContactId();


    @AuraEnabled(cacheable=true)
    public static List<Preferred_Genres__c> prefferedContactGenres(){
        List<Preferred_Genres__c> preferredGenresListOfUser = Database.query(
            'SELECT Movie_Genre__r.Id, Movie_Genre__r.Name, Contact__r.Id, Id FROM Preferred_Genres__c WHERE Contact__r.Id =: contactId'
            '
        );
            
            return preferredGenresListOfUser;
    }

}
