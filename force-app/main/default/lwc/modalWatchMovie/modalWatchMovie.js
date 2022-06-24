import { LightningElement, api, wire } from 'lwc';
import prefferedContactGenres from '@salesforce/apex/CategoryMovieController.prefferedContactGenres';


export default class ModalWatchMovie extends LightningElement {

    showModalWatchMovie = false;
    showRank = false;
    movieValue;
    movieGenres;

    @wire(prefferedContactGenres,{movieId:'$movieValue.Id'})
    movieGenre({ error, data }) {
      if(data){
        this.movieGenres = data;
        console.log(data);
        return 
      }
      console.log(error);
    }




  @api show(evt) {
    this.showModalWatchMovie = true;
    this.movieValue=evt;

  }

  handleDialogClose() {
    this.showModalWatchMovie = false;
  }

  handlePlay(){
    this.showRank= true;
  }


}

