import {LightningElement, wire  } from "lwc";
import getTopMovies from '@salesforce/apex/TopController.getTopMovies';
//import hasAccessUI from '@salesforce/customPermission/MoviePermission';

export default class TopMovies extends LightningElement{
   
    @wire(getTopMovies) movie__c;

 /*   get isUIAccessible(){
        return hasAccessUI;
    }*/

    
}