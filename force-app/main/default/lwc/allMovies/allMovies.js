import { LightningElement, wire } from 'lwc';
import getAllMovies from '@salesforce/apex/allMoviesController.getAllMovies'


export default class AllMovies extends LightningElement {
    @wire(getAllMovies) movies;
}