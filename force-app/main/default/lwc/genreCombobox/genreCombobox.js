import { LightningElement, wire, api, track} from 'lwc';
import getMovieGenres from '@salesforce/apex/GenreController.getMovieGenres';
import getMovies from '@salesforce/apex/MovieByCategory.getMovies';


export default class GenreCombobox extends LightningElement {
    genreList;
    @track data = [];
    @api value;
    @api default;
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
    @wire(getMovieGenres)

     wiredGenre({error, data}){
        if(data){
            var elements = [];
            console.log(data);

            data.forEach(element => {
                elements.push({label: element.Name, value: element.Id});
            });
            elements.push({label: 'Default Movies'});

            this.genreList = [...elements];

            return
        }
        console.log(error);

     }
     get options(){
        return this.genreList;
     } 
   
     handleChange(event){
        this.value = event.detail.value;
        getMovies({categoryId: this.value, pageSize: this.pageSize, pageNumber: this.pageNumber}).then(result =>{
            this.data = result;
            console.log('This is the id: '+this.value);              
        })
        .catch(error => {
            console.error("Error trying to see this category" + error);
        });
     }


    }
    /*get options(){
        return[
            { label: 'Action', value: 'action'},
            { label: 'Adventure', value: 'adventure'},
            { label: 'Animation', value: 'animation'},
            { label: 'Comedy', value: 'comedy'},
            { label: 'Drama', value: 'drama'},
            { label: 'Fantasy', value: 'fantasy'},
            { label: 'Horror', value: 'horror'},
            { label: 'Mystery', value: 'mystery'},
            { label: 'Romance', value: 'romance'},
            { label: 'Thriller', value: 'thriller'},
            { label: 'Default Movies', value: 'dmovies'},
        ];*/
    

   /* handleChange(event){
        this.value = event.detail.value;
        if(this.value == 'action'){
            console.log('This is the test action');
        }
        else if(this.value == 'adventure'){
            console.log('This is the else adventure');
        }
    }*/