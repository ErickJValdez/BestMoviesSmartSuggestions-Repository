import {LightningElement, wire  } from "lwc";
import getTopMovies from '@salesforce/apex/TopController.getTopMovies';


export default class TopMovies extends LightningElement{
   
    @wire(getTopMovies) movie__c;

    
}