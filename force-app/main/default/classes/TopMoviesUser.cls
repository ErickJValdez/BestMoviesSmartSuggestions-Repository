/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-27-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class TopMoviesUser {

    public static List<Movie__c> getDefaultMovies(){
        List<Movie__c> movies = [SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Ranking__c > 3.8 order by Ranking__c DESC LIMIT 10];
        Integer listsize = movies.size();
        List<Movie__c> result = new List<Movie__c>();
        Integer listsize2 = 10 - listsize;
        result.addAll(movies);
        if(listsize < 10){
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Full_Summary__c FROM Movie__c where Global_Score__c > 5 AND Ranking__c = NULL order by Global_Score__c DESC LIMIT :listsize2';
                List<Movie__c> topMovies = Database.query(query);
                result.addAll(topMovies);
        }
        return result;

    }

    //FOR THE TOP 10

    public static List<Movie__c> getChildMovies(){
        List<Movie__c> childresult = new List<Movie__c>();
        String age = UserInfoController.getUserContactAge();
        List<Movie__c> childMovies = new List<Movie__c>();
        
        if(Integer.valueOf(age) <= 13){
            childMovies.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Ranking__c > 3.8 AND (Rating__c = 'Rated G' OR Rating__c = 'Rated PG') order by Ranking__c DESC LIMIT 10]);
            childresult.addAll(childMovies);
            Integer listsize = childMovies.size();
            Integer list2size = 10 - listsize;
            if(listsize < 10){
                String aux = 'Rated G';
                String aux2 = 'Rated PG';
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Global_Score__c > 5 AND Ranking__c = NULL AND (Rating__c = :aux OR Rating__c = :aux2) order by Global_Score__c DESC LIMIT :list2size';
                List<Movie__c> topMovies = Database.query(query);
               childresult.addAll(topMovies);
            }
        }
       
        return childresult;
    }


    public static List<Movie__c> getYoungMovies(){
        List<Movie__c> youngresult = new List<Movie__c>();
        String youngAge = UserInfoController.getUserContactAge();
        List<Movie__c> youngMovies = new List<Movie__c>();

        If(Integer.valueOf(youngAge) <= 30 ){
            youngMovies.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Ranking__c > 3.8 AND (Rating__c = 'Rated PG-13' OR Rating__c = 'Rated PG' OR Rating__c = 'Rated G') order by Ranking__c DESC LIMIT 10]);
            youngresult.addAll(youngMovies);
            Integer listyoungsize = youngMovies.size();
            Integer size2 = 10 - listyoungsize;
            if(listyoungsize < 10){
                String yaux= 'Rated PG-13';
                String rpg = 'Rated PG';
                String rg = 'Rated G';
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Global_Score__c > 5 AND Ranking__c = NULL AND (Rating__c = :yaux OR Rating__c = :rpg OR Rating__c = :rg) order by Global_Score__c DESC LIMIT :size2';
                List<Movie__c> topYoung = Database.query(query);
                youngresult.addAll(topYoung);
            }
        }

        return youngresult;

    }

    public static List<Movie__c> getAdultMovies(){
        List<Movie__c> adultresult = new List<Movie__c>();
        String adultAge = UserInfoController.getUserContactAge();
        List<Movie__c> adultMovies = new List<Movie__c>();

        If(Integer.valueOf(adultAge) > 30){
            adultMovies.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Ranking__c > 3.8 order by Ranking__c DESC LIMIT 10]);
            adultresult.addAll(adultMovies);
            Integer listadultsize = adultMovies.size();
            Integer size3 = 10 - listadultsize;
            if(listadultsize < 10){
                String query = 'SELECT Id,  Name, Image_URL__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Global_Score__c > 5 AND Ranking__c = NULL order by Global_Score__c DESC LIMIT :size3';
                List<Movie__c> topAdult = Database.query(query);
                adultresult.addAll(topAdult);
            }
        }

        return adultresult;
    }


    //FOR ALL MOVIES
    public static List<Movie__c> getAllChildMovies(){
        List<Movie__c> childresult = new List<Movie__c>();
        String age = UserInfoController.getUserContactAge();
        List<Movie__c> childMovies = new List<Movie__c>();
        
        if(Integer.valueOf(age) <= 13){
            childMovies.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE Rating__c = 'Rated G' OR Rating__c = 'Rated PG']);
            childresult.addAll(childMovies);
        }
       
        return childresult;
    }

    public static List<Movie__c> getAllYoungMovies(){
        List<Movie__c> youngresult = new List<Movie__c>();
        String youngAge = UserInfoController.getUserContactAge();
        List<Movie__c> youngMovies = new List<Movie__c>();

        If(Integer.valueOf(youngAge) <= 30 ){
            youngMovies.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c WHERE  Rating__c = 'Rated PG-13' OR (Rating__c = 'Rated G' OR Rating__c = 'Rated PG') LIMIT 20]);
            youngresult.addAll(youngMovies);
        }

        return youngresult;

    }

    public static List<Movie__c> getAllAdultMovies(){
        List<Movie__c> adultresult = new List<Movie__c>();
        String adultAge = UserInfoController.getUserContactAge();
        List<Movie__c> adultMovies = new List<Movie__c>();

        If(Integer.valueOf(adultAge) > 30){
            adultMovies.addAll([SELECT Id, Image_URL__c, Name, Ranking__c, Global_Score__c, Rating__c, Full_Summary__c FROM Movie__c LIMIT 20]);
            adultresult.addAll(adultMovies);
        }

        return adultresult;
    }


}
