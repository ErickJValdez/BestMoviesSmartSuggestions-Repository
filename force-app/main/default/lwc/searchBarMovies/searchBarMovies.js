import { LightningElement, api, track, wire } from 'lwc';

import search from '@salesforce/apex/MoviesSearchBarController.search';

export default class SearchBarMovies extends LightningElement {
    handleSearch(event) {
        const lookupElement = event.target;
        search(event.detail)
            .then(results => {
                lookupElement.setSearchResults(results);
            })
            .catch(error => {
                console.log('The movie wasn\'t found' + error);
            });
    }
    

}