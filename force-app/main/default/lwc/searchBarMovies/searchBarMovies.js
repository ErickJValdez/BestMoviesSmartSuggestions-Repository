import { LightningElement, track } from 'lwc';
import displayMovieRecords from '@salesforce/apex/MoviesSearchBarController.displayMovieRecords';

export default class SearchBarMovies extends LightningElement {
    @track movMovieTitle;
    handleChange(event){
        this.movMovieTitle=event.target.value;
        console.log('MovieTitle'+this.movMovieTitle);

    }
}