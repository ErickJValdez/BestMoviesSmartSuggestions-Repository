/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-13-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/


public with sharing class SuggestionsController {

    public SuggestionsController() {

    }

    
    
  //The method is cacheable, means the response will cached in the browser
  @AuraEnabled(cacheable=true)
  public static List<Movies> getAllMovies() {
    List<SObject> todos = Database.query(
      'SELECT Id, Name, CreatedDate, Done__c FROM ToDo__c WHERE CreatedDate = LAST_N_DAYS:7 ORDER BY CreatedDate DESC'
    );

    return getToDos(todos);
  }


  


  
}
