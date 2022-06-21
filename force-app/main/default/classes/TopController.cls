/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-21-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class TopController {
    @AuraEnabled(cacheable=true)

    public static List<Movie__c> getTopMovies(){
        List<Movie__c> topMoviesList =[SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Full_Summary__c FROM Movie__c where Ranking__c > 3.8 order by Ranking__c DESC LIMIT 10];
        Integer listsize = topMoviesList.size();
        List<Movie__c> listresult = new List<Movie__c>();
        Integer list2size = 10 - listsize;
        listresult.addAll(topMoviesList);
        if(listsize < 10){
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Full_Summary__c FROM Movie__c where Global_Score__c > 5 AND Ranking__c = NULL order by Global_Score__c DESC LIMIT :list2size';
                List<Movie__c> topMovies = Database.query(query);
                listresult.addAll(topMovies);
            
        }    
         
        return listresult;

    }

}