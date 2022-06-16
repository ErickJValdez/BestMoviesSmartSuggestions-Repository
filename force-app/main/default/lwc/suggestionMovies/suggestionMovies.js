import { LightningElement, api, wire } from 'lwc';

import getMoviesSuggestion from '@salesforce/apex/MoviesController.getMoviesSuggestion';


export default class SuggestionMovies extends LightningElement {
    @wire(getMoviesSuggestion) Movies;



    


}