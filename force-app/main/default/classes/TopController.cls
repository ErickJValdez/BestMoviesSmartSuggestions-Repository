
public class TopController {
    @AuraEnabled(cacheable=true)

    public static List<Movie__c> getTopMovies(){
        List<Movie__c> topMoviesList =[SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Full_Summary__c FROM Movie__c where Ranking__c != NULL order by Ranking__c DESC LIMIT 10];
        Integer listnum = topMoviesList.size();
        List<Movie__c> listresult = new List<Movie__c>();
        listresult.addAll(topMoviesList);
        if(listnum < 10){
                List<Movie__c> topMovies = [SELECT Id,  Name, Image_URL__c, Global_Score__c, Full_Summary__c FROM Movie__c where Global_Score__c > 50 AND Ranking__c = NULL LIMIT 10];
                listresult.addAll(topMovies);
            
        }    
         
        return listresult;

    }

}