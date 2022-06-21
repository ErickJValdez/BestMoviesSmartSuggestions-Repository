public class MoviesCallouts {
    
    public static Double getMovieRaitings(String name){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.omdbapi.com/?t='+name+'&apikey=ad509f2');
        request.setMethod('GET');
        System.debug('>>>>>>>'+name);
        HttpResponse response = http.send(request);
        Double returnValue;
       
        // If the request is successful, parse the JSON response
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
             String ratings1 = (String) result.get('imdbRating');
            
            Double va = Double.valueOf(ratings1);
            
          						 /* List<Object> ratings = (List<Object>) result.get('Ratings');
         						  Map<String, Object> result2 = (Map<String, Object>) ratings.get(0);*/
                                  
            returnValue = va;
            
                                    // System.debug(va);
        }
        return returnValue;
     
    }
}