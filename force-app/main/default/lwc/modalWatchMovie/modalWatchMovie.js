import { LightningElement, api, wire } from 'lwc';

import movieGenresList from '@salesforce/apex/CategoryMovieController.movieGenres';
import checkIfWatchedMovie from '@salesforce/apex/MovieRankingController.checkIfWatchedMovie';
import createMovieWatchRecord from '@salesforce/apex/MovieRankingController.createMovieWatchRecord';
import checkIfRankedByUser from '@salesforce/apex/MovieRankingController.checkIfRankedByUser';
import rankMovie from '@salesforce/apex/MovieRankingController.rankMovie';
import updateRankMovie from '@salesforce/apex/MovieRankingController.updateRankMovie';

import movieLike from '@salesforce/apex/SuggestionsController.movieLike';
import movieDislike from '@salesforce/apex/SuggestionsController.movieDislike';
import checkMovieLike from '@salesforce/apex/SuggestionsController.checkMovieLike';




export default class ModalWatchMovie extends LightningElement {

    showModalWatchMovie = false;
    showRankSection;
    movieValue;
    movieGenres;
    movieLikeVar= false;

    rankingValues;

    allowRank=true;

    @api show(evt) {
      this.showModalWatchMovie = true;
      this.movieValue=evt; 
      this.checkIfRanked();
      this.checkIfWatched();
      this.checkIfMovieLiked();

    }

   checkIfRanked(){

    checkIfRankedByUser({movieId: this.movieValue.Id}).then(
      result =>{ 
        if (result) {
          this.rankingValues = result;
      }
    }).catch(error => {
      console.log('Check If rank by user '+ error);
    });
      
   }


  
   checkIfWatched(){

    checkIfWatchedMovie({movieId: this.movieValue.Id}).then(
      result =>{ 
        if (!result) {
          this.showRankSection = result;
       } else {
        this.showRankSection = true;
      }
    }).catch(error => {
      console.log('Check If movie watched '+ error);
    });

   }

   checkIfMovieLiked(){

    checkMovieLike({movieId: this.movieValue.Id}).then(
      result =>{ 
        if (result) {
          this.movieLikeVar = result;

          if(this.template.querySelector("button")){
            const button = this.template.querySelector("button");
            button.className+=" selected";
          }
       }
    }).catch(error => {
      console.log('Check If movie liked '+ error);
    });
   }

   get Rank(){
    if(this.rankingValues){
      return this.rankingValues.Rank__c;
    } else {
      return '';
    }
   }
 
    @wire(movieGenresList,{movieId:'$movieValue.Id'})
    movieGenre({ error, data }) {
      if(data){
        this.movieGenres = data;
        console.log(data);
        return 
      }
      console.log('Movie genre '+ error);
    }


  showToastRanked() {
    this.template.querySelector('c-custom-toast').showToast('success', 'The movie has been ranked');
   }

   showToastUpdate() {
    this.template.querySelector('c-custom-toast').showToast('success', 'The rank has been updated');
   }
  

  handleSubmitRanking(){

    const inputRanking = this.template.querySelector("lightning-input");

    console.log('Clicked on submit buttom, the input data is: '+ inputRanking.value);
   
    if(this.rankingValues){
      console.log('Movie already ranked let\'s update it');
      updateRankMovie({rankId: this.rankingValues.Id, rankNumber: inputRanking.value}).then(
        result =>{ if (result) {
          console.log('Rank updated:'+ result);
          this.showToastUpdate();
        }
      }).catch(error => {
          console.error("Error trying to update the rank record: " + error);
        });
        
        return;
    } 

      console.log('Movie hasn\'s been ranked let\'s rank it');

      rankMovie({movieId: this.movieValue.Id, rankNumber: inputRanking.value}).then(
        result =>{ if (result) {
          console.log('Rank Submitted:'+ result);
          this.showToastRanked();
          this.checkIfRanked();
        }
      }).catch(error => {
          console.error("Error trying to submit the rank record: " + error);
        });


  }


  handleDialogClose() {
    this.showModalWatchMovie = false;
  }

  handlePlay(){

    if(this.showRankSection==false){
      console.log('Show movie:' + this.movieValue.Id);

        createMovieWatchRecord({movieId: this.movieValue.Id}).then(result =>{ if (result) {
            this.showRankSection = true;
            console.log('Movie Watched Created');
          }
        })
        .catch(error => {
          console.error("Error trying to see the movie" + error);
        });
    } else { console.log('The movie has been watched');}
  }


  likeButtonHandler(){
 
    if(this.movieLikeVar){

      console.log('I disliked the movie');

      const button = this.template.querySelector("button");
      button.className="like-button";

      movieDislike({movieId: this.movieValue.Id}).then(
        result =>{ 
              console.log('Movie disliked '+ result);
      }).catch(error => {
        console.log('Movie disliked error: '+ error);
      });
      this.movieLikeVar = false;
      return
    } else {
        console.log('I liked the movie');

      const button = this.template.querySelector("button");
      button.className+=" selected";

      movieLike({movieId: this.movieValue.Id}).then(
        result =>{ 
          if (result) {
              console.log('Movie liked '+ result);
        }
      }).catch(error => {
        console.log('Check If movie liked error: '+ error);
      });

      this.movieLikeVar = true;  
    return
  }
}

}