import { LightningElement } from 'lwc';

export default class GrandParent extends LightningElement {
    constructor() {
        super();
        console.log('##Grand Parent Constructor');
    }
    connectedCallback(){
        console.log('##Grand Parent Connected Call Back');
    }
    renderedCallback() {
        console.log('##Grand Parent Rendered Call Back');
    }
}