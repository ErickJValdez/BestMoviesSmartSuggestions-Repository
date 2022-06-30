import { LightningElement, api, wire, track } from 'lwc';
import prefferedContactGenres from '@salesforce/apex/CategoryMovieController.prefferedContactGenres';
import checkIfWatchedMovie from '@salesforce/apex/MovieRankingController.checkIfWatchedMovie';
import createMovieWatchRecord from '@salesforce/apex/MovieRankingController.createMovieWatchRecord';
import checkIfRankedByUser from '@salesforce/apex/MovieRankingController.checkIfRankedByUser';
import rankMovie from '@salesforce/apex/MovieRankingController.rankMovie';
import updateRankMovie from '@salesforce/apex/MovieRankingController.updateRankMovie';


export default class ModalWatchMovie extends LightningElement {

    showModalWatchMovie = false;
    showRankSection;
    movieValue;
    movieGenres;

    rankingValues;

    allowRank=true;

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

  showToastRanked() {
    this.template.querySelector('c-custom-toast').showToast('success', 'The movie has been ranked');
   }

   showToastUpdate() {
    this.template.querySelector('c-custom-toast').showToast('success', 'The rank has been updated');
   }
  
  
  @wire(checkIfWatchedMovie,{movieId:'$movieValue.Id'})
  checkIfMovieWatched({ error, data }) {
    if(!data){
      this.showRankSection = data;
      console.log(data);
      return 
    } else {
      this.showRankSection = true;
    }
    console.log(error);
  }

  @wire(checkIfRankedByUser,{movieId:'$movieValue.Id'})
  rankByUser({ error, data }) {
    if(data){
      this.rankingValues = data;
      console.log(data);
      this.template.querySelector("lightning-input").value=this.rankingValues.Rank__c;
      return 
    }
    console.log(error);
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
          this.reloadPage();

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
          this.reloadPage();
      
        }
      }).catch(error => {
          console.error("Error trying to submit the rank record: " + error);
        });


  }

  updateRecordView() {
    setTimeout(() => {
         eval("$A.get('e.force:refreshView').fire();");
    }, 3000); 
 }

 reloadPage() {
  setTimeout(() => {
    window.location.reload();
  }, 2000); 
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


}

