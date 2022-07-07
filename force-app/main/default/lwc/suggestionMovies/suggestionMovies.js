import { LightningElement, api, wire } from 'lwc';

import getMoviesSuggestion from '@salesforce/apex/SuggestionsController.getMoviesSuggestion';


export default class SuggestionMovies extends LightningElement {
    @wire(getMoviesSuggestion) Movies;



    


}