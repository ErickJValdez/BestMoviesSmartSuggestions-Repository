import { LightningElement, api, wire } from 'lwc';
import getMovies from '@salesforce/apex/MoviesController.getMovies';

export default class SuggestionMovies extends LightningElement {
    @wire(getMovies) Movies;

}