public class MoviesCalloutsBatchApex implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful{
   
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
   
    //public String query = 'SELECT Name FROM Movie__c';
      
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Name FROM Movie__c');
     }
 
    public void execute(Database.BatchableContext BC, List<Movie__c> scope) {    

        List<Movie__c> moviesToUpdate = New List<Movie__c>();

         System.debug('Este es el scope de todas las peliculas -->'+ scope);
        
        for(Movie__c movie : scope){

            try {   
            Http http = new Http();
            HttpRequest request = new HttpRequest();
                String s1 = movie.name;
				String regExp = ' ';
				String replacement = '%20';
				String s2 = s1.replaceAll(regExp, replacement);
                
            request.setEndpoint('http://www.omdbapi.com/?t='+s2+'&apikey=ad509f2');
            request.setMethod('GET');
                              
               System.debug('Este es un request -->' + request);
                
            HttpResponse response = http.send(request);
            Double globalScore;
			
           
                System.debug('Este es un response body -->' + response.getBody());
                
           if (response.getStatusCode() == 200) {
                // Deserialize the JSON string into collections of primitive data types.
                  Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            		
             
                 String ratings1 = (String) result.get('imdbRating');
              	 String posterImage = (String) result.get('Poster');  
            		
              		 System.debug(ratings1+ ' '+ posterImage);
               
                     globalScore = Double.valueOf(ratings1);				
                                  
                    movie.Global_Score__c = globalScore;
               		//movie.Image_URL__c =posterImage;
               
                    moviesToUpdate.add(movie);
                    recordsProcessed = recordsProcessed + 1;
             }

          }
           catch (Exception e) {         
            System.debug('Error:' + e.getMessage() + 'Line no:' + e.getLineNumber() );           
            }
        }
        update moviesToUpdate;
    }   
 
    public void finish(Database.BatchableContext BC){
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }
    
}