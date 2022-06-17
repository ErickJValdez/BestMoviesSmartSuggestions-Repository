<<<<<<< HEAD
import { LightningElement, track, wire } from 'lwc';
=======
import { LightningElement, track,wire,api} from 'lwc';
>>>>>>> 9ba4e41096e531c9741f7b80ef030eb378d023d0
import displayMovieRecords from '@salesforce/apex/MoviesSearchBarController.displayMovieRecords';
import Movie from '../movie/movie';


export default class SearchBarMovies extends LightningElement {
<<<<<<< HEAD
    @wire(displayMovieRecords) MoviesTitles;

    @track movMovieTitle;
=======
    @api movMovieTitle;
    @track records; 
    @track error;
    @api recordId;
        
    @wire (displayConRecords,{searchkey:'$movMovieTitle'})   

    wireMovies({error,data}){
        if (data){
            this.records=data;
            this.error=error;    
        }
        else{
            this.error=error;
            this.error=undefined;
        }
    }
>>>>>>> 9ba4e41096e531c9741f7b80ef030eb378d023d0
    handleChange(event){
        this.movMovieTitle=event.target.value;
        console.log('MovieTitle'+this.movMovieTitle);

    }
}