public class MoviesCalloutsBatchApex implements Database.Batchable<sObject>,   Database.AllowsCallouts{
    
    public String query = 'SELECT Name FROM Movie__c';
      
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
     }
 
    public void execute(Database.BatchableContext BC, List<Movie__c> scope) {    

        List<Movie__c> moviesToUpdate = New List<Movie__c>();

        String endpoint;  

        for(Movie__c movie : scope){
            try {   
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://www.omdbapi.com/?t='+movie.name+'&apikey=ad509f2');
            request.setMethod('GET');
            //System.debug('>>>>>>>'+scope.name);
            HttpResponse response = http.send(request);
           // Double returnValue;

           if (response.getStatusCode() == 200) {
                // Deserialize the JSON string into collections of primitive data types.
                  Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
                 String ratings1 = (String) result.get('imdbRating');
            
                    Double globalScore = Double.valueOf(ratings1);				
                                  
                    movie.Global_Score__c = globalScore;
                    moviesToUpdate.add(movie);
            
             }

          }
            catch (Exception e) {         
            System.debug('Error:' + e.getMessage() + 'Line no:' + e.getLineNumber() );           
            }
        }

        update moviesToUpdate;
    }   
 
    public void finish(Database.BatchableContext BC){}
    
}
