/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-20-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class GetRequest {
    public static HttpResponse getMovieRaitings(String name){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.omdbapi.com/?t='+name+'&apikey=ad509f2');
        request.setMethod('GET');
        System.debug('>>>>>>>'+name);
        HttpResponse response = http.send(request);
        String returnValue;
       
        // If the request is successful, parse the JSON response
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> ratings = (List<Object>) result.get('Ratings');
           Map<String, Object> result2 = (Map<String, Object>) ratings.get(0);
           System.debug(result2.get('Value'));
                      
        }
        return response;
     
    }
}