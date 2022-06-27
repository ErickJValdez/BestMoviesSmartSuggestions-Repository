import { LightningElement } from 'lwc';

export default class GenreCombobox extends LightningElement {
    get options(){
        return[
            { label: 'Action', value: 'action'},
            { label: 'Adventure', value: 'adventure'},
            { label: 'Animation', value: 'animation'},
            { label: 'Comedy', value: 'comedy'},
            { label: 'Drama', value: 'drama'},
            { label: 'Fantasy', value: 'fantasy'},
            { label: 'Horror', value: 'horror'},
            { label: 'Mystery', value: 'mystery'},
            { label: 'Romance', value: 'romance'},
            { label: 'Thriller', value: 'thriller'},
            { label: 'Default Movies', value: 'dmovies'},
        ];
    }

    handleChange(event){
        this.value = event.detail.value;
    }




}