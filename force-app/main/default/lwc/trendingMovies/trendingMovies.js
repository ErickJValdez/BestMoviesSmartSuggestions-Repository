import { LightningElement, wire } from 'lwc';
import getTrendMovies from '@salesforce/apex/TrendingController.getTrendMovies';

export default class TrendingMovies extends LightningElement {

    firstSectionMovies;
    secondSectionMovies;

    connectedCallback(){

        getTrendMovies()
        .then(result => {
            let first=[];
            let second=[];
            if (result) {
                for (let i = 0; i < result.length; i++) {
                if(i<5){
                    first.push(result[i]);
                } else if (i>=5){
                    second.push(result[i]);
                }
            }
    
            this.firstSectionMovies=first;
            this.secondSectionMovies=second;
            }
        }).catch(error => {
            console.log(error);
        });
    
    }

   // @wire(getTrendMovies) movies;
}