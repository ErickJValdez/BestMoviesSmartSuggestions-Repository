/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-12-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class TopController {
    @AuraEnabled(cacheable=true)

    public static List<Movie__c> getTopMovies(){
        
        List<Movie__c> childresult = TopMoviesUser.getChildMovies();
        List<Movie__c> youngresult = TopMoviesUser.getYoungMovies();
        List<Movie__c> adulresult = TopMoviesUser.getAdultMovies();
        //List<Movie__c> movies = TopMoviesUser.getDefaultMovies();
        String age = UserInfoController.getUserContactAge();
        if(Integer.valueOf(age) <= 13){
            return childresult;
        }
        else if(Integer.valueOf(age) <= 30){
            return youngresult;
        }
        else{
            return adulresult;
        }
    }

    
        








        // List<Movie__c> topMoviesList =[SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Full_Summary__c FROM Movie__c WHERE Ranking__c > 3.8 order by Ranking__c DESC LIMIT 10];
        //Integer listsize = topMoviesList.size();
        //List<Movie__c> result = new List<Movie__c>();
        //Integer list2size = 10 - listsize;
        //listresult.addAll(topMoviesList);
       /* if(listsize < 10){
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Full_Summary__c FROM Movie__c where Global_Score__c > 5 AND Ranking__c = NULL order by Global_Score__c DESC LIMIT :list2size';
                List<Movie__c> topMovies = Database.query(query);
                //listresult.addAll(topMovies);
            
        }   */ 
    //}
      
        
    

}