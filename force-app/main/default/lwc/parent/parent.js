import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {
    constructor() {
        super();
        console.log('##Parent Constructor');
    }
    connectedCallback(){
        console.log('##Parent Connected Call Back');
    }
    renderedCallback() {
        console.log('##Parent Rendered Call Back');
    }
}