import { LightningElement, api } from 'lwc';

export default class ModalWatchMovie extends LightningElement {

    showModalWatchMovie = false;
    movieValue;

  @api show(evt) {
    this.showModalWatchMovie = true;
    this.movieValue=evt;

  }

  handleDialogClose() {
    this.showModalWatchMovie = false;
  }
}

