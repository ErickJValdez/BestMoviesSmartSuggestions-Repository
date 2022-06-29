import { LightningElement } from 'lwc';

import search from '@salesforce/apex/MoviesSearchBarController.search';

export default class SearchBarMovies extends LightningElement {
    results = [];
    
    handleSearch(event) {
        const lookupElement = event.target;
        search(event.detail)
            .then(results => {
                this.results = results;
                lookupElement.setSearchResults(results);
            })
            .catch(error => {
                console.log('The movie wasn\'t found' + error);
            });
    }

    handleSelectionChange(event) {
        const selectedId = event.detail?.[0];

        if(!selectedId) {
            return;
        }
        
        const selectedMovie = this.results.find(movie => movie.id === selectedId)?.payload;

        const modal = this.template.querySelector("c-modal-Watch-Movie");
        modal.show( selectedMovie );
    }
}