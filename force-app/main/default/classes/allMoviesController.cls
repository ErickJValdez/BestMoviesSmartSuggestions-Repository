/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-11-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class allMoviesController {

    public class moviesItemWrapper {
        public Integer recordStart {get;set;}
        public Integer pageNumber {get;set;}
        public Integer totalRecords {get;set;}
        public Integer recordEnd {get;set;}
        public Integer pageSize {get;set;}
        public List<Movie__c> moviesL {get;set;}
    }

        @AuraEnabled(cacheable=true)

    public static String getAllMovies(Integer pageSize, Integer pageNumber){

        String jsonObjItm = '';
        Integer offset = (pageNumber - 1) * pageSize;

        Integer recordEnd = pageSize * pageNumber;
        //Integer totalChildRecords = [SELECT COUNT() FROM Movie__c WHERE Rating__c = 'Rated G' OR Rating__c = 'Rated PG'];
        //Integer totalYoungRecords = [SELECT COUNT() FROM Movie__c WHERE Rating__c = 'Rated PG-13' OR (Rating__c = 'Rated G' OR Rating__c = 'Rated PG')];
        //Integer totalAdultRecords = [SELECT COUNT() FROM Movie__c];
        Integer totalRecords = [SELECT COUNT() FROM Movie__c];


        List<Movie__c> childresult = TopMoviesUser.getAllChildMovies(pageSize, offset);
        List<Movie__c> youngresult = TopMoviesUser.getAllYoungMovies(pageSize, offset);
        List<Movie__c> adulresult = TopMoviesUser.getAllAdultMovies(pageSize, offset);
        List<Movie__c> movies = TopMoviesUser.getDefaultMovies();
        String age = UserInfoController.getUserContactAge();
        
            if(Integer.valueOf(age) <= 13){
                totalRecords = [SELECT COUNT() FROM Movie__c WHERE Rating__c = 'Rated G' OR Rating__c = 'Rated PG'];
                moviesItemWrapper movObj = new moviesItemWrapper();
                movObj.pageNumber = pageNumber;
                movObj.pageSize = pageSize;
                movObj.recordStart = offset + 1;
                //movObj.recordEnd = totalChildRecords >= recordEnd ? recordEnd : totalChildRecords;
                //movObj.totalChildRecords = totalChildRecords;
                movObj.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                movObj.totalRecords = totalRecords;
                movObj.moviesL = childresult;
                jsonObjItm = JSON.serialize(movObj);
                return jsonObjItm;
            }
            else if(Integer.valueOf(age) <= 30){
                totalRecords = [SELECT COUNT() FROM Movie__c WHERE Rating__c = 'Rated PG-13' OR (Rating__c = 'Rated G' OR Rating__c = 'Rated PG')];
                moviesItemWrapper movObj = new moviesItemWrapper();
                movObj.pageNumber = pageNumber;
                movObj.pageSize = pageSize;
                movObj.recordStart = offset + 1;
               // movObj.recordEnd = totalYoungRecords >= recordEnd ? recordEnd : totalYoungRecords;
                //movObj.totalYoungRecords = totalYoungRecords;
                movObj.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                movObj.totalRecords = totalRecords;
                movObj.moviesL = youngresult;
                jsonObjItm = JSON.serialize(movObj);
                return jsonObjItm;
            }
            else if(Integer.valueOf(age) > 30){
                moviesItemWrapper movObj = new moviesItemWrapper();
                movObj.pageNumber = pageNumber;
                movObj.pageSize = pageSize;
                movObj.recordStart = offset + 1;
                //movObj.recordEnd = totalAdultRecords >= recordEnd ? recordEnd : totalAdultRecords;
                //movObj.totalAdultRecords = totalAdultRecords;
                movObj.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                movObj.totalRecords = totalRecords;
                movObj.moviesL = adulresult;
                jsonObjItm = JSON.serialize(movObj);
                return jsonObjItm;
            }
            else{
                moviesItemWrapper movObj = new moviesItemWrapper();
                movObj.pageNumber = pageNumber;
                movObj.pageSize = pageSize;
                movObj.recordStart = offset + 1;
                //movObj.recordEnd = totalAdultRecords >= recordEnd ? recordEnd : totalAdultRecords;
                //movObj.totalAdultRecords = totalAdultRecords;
                movObj.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
                movObj.totalRecords = totalRecords;
                movObj.moviesL = movies;
                jsonObjItm = JSON.serialize(movObj);
                return jsonObjItm;
            }
      
        //jsonObjItm = JSON.serialize(movObj);
        //return jsonObjItm;

     

        
        
    }

    
}