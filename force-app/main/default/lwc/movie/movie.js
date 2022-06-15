import { LightningElement, api } from 'lwc';

export default class Movie extends LightningElement {
    
@api movie;

handleMovieClickShowModal() {
    const modal = this.template.querySelector("c-modal-Watch-Movie");
    modal.show(this.movie);
  
}

}

