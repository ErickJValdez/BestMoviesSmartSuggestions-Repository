import { LightningElement, wire } from 'lwc';
import getAllMovies from '@salesforce/apex/allMoviesController.getAllMovies'


export default class AllMovies extends LightningElement {
    @wire(getAllMovies) movies;
    handlePageChange(){
        getAllMovies().then(result => {
            console.log("Prueba");
        })
    }
    
    handleNextPage(event){
        if(this.pageNumber < this.totalPageCount){
            this.pageNumber = this.pageNumber + 1;
        }
        console.log("Current Page: " +this.pageNumber);
        this.handlePageChange();
    }
}