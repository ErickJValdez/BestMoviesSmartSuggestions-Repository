import { LightningElement, api, wire } from 'lwc';

import getMoviesSuggestion from '@salesforce/apex/SuggestionsController.getMoviesSuggestion';


export default class SuggestionMovies extends LightningElement {

    firstSectionMovies;
    secondSectionMovies;


connectedCallback(){

    getMoviesSuggestion()
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

  

     //@wire(getMoviesSuggestion) Movies;
}