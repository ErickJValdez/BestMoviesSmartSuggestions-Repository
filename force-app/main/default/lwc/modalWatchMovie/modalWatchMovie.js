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

    rankingNewValues=0; // Added for the star process

    @api show(evt) {
      this.showModalWatchMovie = true;
      this.movieValue=evt; 
      this.checkIfWatched();
      this.checkIfRanked();
      this.checkIfMovieLiked();
    }


   checkIfRanked(){

    checkIfRankedByUser({movieId: this.movieValue.Id}).then(
      result =>{ 
        if (result) {
          this.rankingValues = result;

          this.rankingNewValues = this.rankingValues.Rank__c;

        }
    }).catch(error => {
      console.log('Check If rank by user '+ error);
    });
      
   }

   rating(event) {

    this.modifyStars();


    this.rankingNewValues=event.target.value;
   


  }



  modifyStars(){

    let radioInput= this.template.querySelectorAll('input');

      radioInput.forEach( inputField => {
        if(!(inputField.checked)) {
          inputField.className="star";
        }
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

    //const inputRanking = this.template.querySelector("lightning-input");

    //console.log('Clicked on submit buttom, the input data is: '+ inputRanking.value);
   
    if(this.rankingValues){
      console.log('Movie already ranked let\'s update it');
      updateRankMovie({rankId: this.rankingValues.Id, rankNumber: this.rankingNewValues}).then(
        result =>{ if (result) {
          console.log('Rank updated:'+ result);
          this.showToastUpdate();
          this.checkIfRanked();
        }
      }).catch(error => {
          console.error("Error trying to update the rank record: " + error);
        });
        
        return;
    } 

      console.log('Movie hasn\'s been ranked let\'s rank it');

      rankMovie({movieId: this.movieValue.Id, rankNumber: this.rankingNewValues}).then(
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
renderedCallback(){
  this.checkRank();
}

checkRank(){

  if(this.showModalWatchMovie){
  if(this.rankingValues){
    if(this.rankingValues.Rank__c){
          
      if(this.rankingValues.Rank__c >= 5){
          const button=   this.template.querySelector(".fiveStars");
          button.className+=" chose";
  
      } else if(this.rankingValues.Rank__c >=4){
  
          const button=   this.template.querySelector(".fourStars");
          button.className+=" chose";
  
  
      } else if(this.rankingValues.Rank__c >=3){
  
          const button=   this.template.querySelector(".threeStars");
          button.className+=" chose";
  
  
      } else if(this.rankingValues.Rank__c >=2){
          const button=   this.template.querySelector(".twoStars");
          button.className+=" chose";
  
  
      } else if(this.rankingValues.Rank__c >=1){
          
          const button=   this.template.querySelector(".oneStar");
          button.className+=" chose";
  
      }
  }
}
}
}

/*checkGlobalRank(){

  if(this.movieValue.Ranking__c!= null){
    if(this.movieValue.Ranking__c){
          
      if(this.movieValue.Ranking__c>= 5){
          const button=   this.template.querySelector(".CfiveStars");
          button.className+=" chose";
  
      } else if(this.movieValue.Ranking__c>=4){
  
          const button=   this.template.querySelector(".CfourStars");
          button.className+=" chose";
  
  
      } else if(this.movieValue.Ranking__c>=3){
  
          const button=   this.template.querySelector(".CthreeStars");
          button.className+=" chose";
  
  
      } else if(this.movieValue.Ranking__c>=2){
          const button=   this.template.querySelector(".CtwoStars");
          button.className+=" chose";
  
  
      } else if(this.movieValue.Ranking__c>=1){
          
          const button=   this.template.querySelector(".ConeStar");
          button.className+=" chose";
  
      }
  }
}
}*/

}