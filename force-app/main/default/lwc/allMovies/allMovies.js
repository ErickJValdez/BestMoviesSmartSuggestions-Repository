import { LightningElement, wire, track } from 'lwc';
import getAllMovies from '@salesforce/apex/allMoviesController.getAllMovies'


export default class AllMovies extends LightningElement {
    @wire(getAllMovies) movies;
   
    @track recordEnd = 0;
    @track recordStart = 0;
    @track pageNumber = 1;
    @track totalRecords = 0;
    @track totalChildRecords = 0;
    @track totalYoungRecords = 0;
    @track totalAdultRecords = 0;
    @track totalPages = 0;
    @track loaderSpinner = false;
    @track error = null;
    @track pageSize = 10;
    @track isPrev = true;
    @track isNext = true;
    @track moviesL = [];

    connectedCallback(){
        this.getMovies();
    }

    handlePageNextAction(){
        this.pageNumber = this.pageNumber +1;
        this.getMovies();
    }

    handlePagePrevAction(){
        this.pageNumber = this.pageNumber - 1;
        this.getMovies();
    }

    getMovies(){
        this.loaderSpinner = true;
        getAllMovies({pageSize: this.pageSize, pageNumber: this.pageNumber}).then(result => {
            this.loaderSpinner = false;
            if(result){
                console.log(result);
                var resultData = JSON.parse(result);
                console.log(resultData);
                this.recordEnd = resultData.recordEnd;
                this.totalRecords = resultData.totalRecords;
                this.recordStart = resultData.recordStart;
                this.moviesL = resultData.moviesL;
                this.pageNumber = resultData.pageNumber;
                this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
                this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
                this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);
        }
    })
    .catch(error =>{
        this.loaderSpinner = false;
        this.error = error;
    });  
}

get isDisplayNoRecords(){
    var isDisplay = true;
    if(this.moviesL){
        if(this.moviesL.length == 0){
            isDisplay = true;
        }else{
            isDisplay = false;
        }
    }
    return isDisplay;
}

}