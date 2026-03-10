import { LightningElement } from 'lwc';

export default class AnotherChild extends LightningElement {
    constructor() {
        super();
        console.log('##Second Child Constructor');
    }
    connectedCallback(){
        console.log('##Second Child Connected Call Back');
    }
    renderedCallback() {
        console.log('##Second Child Rendered Call Back');
    }
}