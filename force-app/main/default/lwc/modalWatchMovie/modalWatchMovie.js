import { LightningElement, api, wire } from 'lwc';
import prefferedContactGenres from '@salesforce/apex/CategoryMovieController.prefferedContactGenres';
import checkIfWatchedMovie from '@salesforce/apex/MovieRankingController.checkIfWatchedMovie';
import createMovieWatchRecord from '@salesforce/apex/MovieRankingController.checkIfWatchedMovie';

export default class ModalWatchMovie extends LightningElement {

    showModalWatchMovie = false;
    showRankSection;
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
  
  
  @wire(checkIfWatchedMovie,{movieId:'$movieValue.Id'})
  checkIfMovieWatched({ error, data }) {
    if(!data){
      this.showRankSection = data;
      console.log(data);
      return 
    }
    console.log(error);
  }

  handleDialogClose() {
    this.showModalWatchMovie = false;
  }

  handlePlay(){

    const movieW= {movie: this.movieValue.Id};

    console.log(movieW);
    if(this.showRankSection==false){
      console.log('Show movie:' + movieW);

        createMovieWatchRecord({movieId: JSON.stringify(movieW)}).then(result => {
          if (result) {
            this.showRankSection = true;
            console.log('Movie Watched Created');
          }
        })
        .catch(error => {
          console.error("Error creating movie watched" + error);
        });
    } else { console.log('Show rank section is true');}
    console.log('Last log on handlePlay');
  }


}

