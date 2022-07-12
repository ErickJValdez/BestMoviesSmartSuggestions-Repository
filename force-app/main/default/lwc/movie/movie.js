import { LightningElement, api } from 'lwc';

export default class Movie extends LightningElement {

@api movie;

handleMovieClickShowModal() {
const modal = this.template.querySelector("c-modal-Watch-Movie");
modal.show(this.movie); 
}

renderedCallback(){
    this.checkRank();
}

checkRank(){

if(this.movie.Ranking__c!=null){
        
    if(this.movie.Ranking__c >= 5){
        const button=   this.template.querySelector(".fiveStars");
        button.className+=" selected";

    } else if(this.movie.Ranking__c >=4){

        const button=   this.template.querySelector(".fourStars");
        button.className+=" selected";


    } else if(this.movie.Ranking__c >=3){

        const button=   this.template.querySelector(".threeStars");
        button.className+=" selected";


    } else if(this.movie.Ranking__c >=2){
        const button=   this.template.querySelector(".twoStars");
        button.className+=" selected";


    } else if(this.movie.Ranking__c >=1){
        
        const button=   this.template.querySelector(".oneStars");
        button.className+=" selected";

    }
}
}



}