import { LightningElement, track,wire,api} from 'lwc';
import displayMovieRecords from '@salesforce/apex/MoviesSearchBarController.displayMovieRecords';
import Movie from '../movie/movie';


export default class SearchBarMovies extends LightningElement {
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
    handleChange(event){
        this.movMovieTitle=event.target.value;
        console.log('MovieTitle'+this.movMovieTitle);

    }
}