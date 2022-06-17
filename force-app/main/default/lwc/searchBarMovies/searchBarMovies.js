import { LightningElement, track, wire } from 'lwc';
import displayMovieRecords from '@salesforce/apex/MoviesSearchBarController.displayMovieRecords';

export default class SearchBarMovies extends LightningElement {
    @wire(displayMovieRecords) MoviesTitles;

    @track movMovieTitle;
    handleChange(event){
        this.movMovieTitle=event.target.value;
        console.log('MovieTitle'+this.movMovieTitle);

    }
}