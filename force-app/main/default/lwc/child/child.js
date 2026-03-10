import { LightningElement } from 'lwc';

export default class Child extends LightningElement {
    constructor() {
        super();
        console.log('##First Child Constructor');
    }
    connectedCallback(){
        console.log('##First Child Connected Call Back');
    }
    renderedCallback() {
        console.log('##First Child Rendered Call Back');
    }
}