import {LightningElement, wire  } from "lwc";
import getTopMovies from '@salesforce/apex/TopController.getTopMovies';



export default class TopMovies extends LightningElement{
    
    firstSectionMovies;
    secondSectionMovies;

    connectedCallback(){

        getTopMovies()
        .then(result => {
          let first=[];
          let second=[];
            if (result) {
              for (let i = 0; i < result.length; i++) {
                if(i<5){
                  first.push(result[i]);
                } else if (i>=5){
                  second.push(result[i]);
                }
          }
    
          this.firstSectionMovies=first;
          this.secondSectionMovies=second;
        }
      }).catch(error => {
          console.log(error);
        });
    
      }
    
   
    //@wire(getTopMovies) movie__c;

    
}