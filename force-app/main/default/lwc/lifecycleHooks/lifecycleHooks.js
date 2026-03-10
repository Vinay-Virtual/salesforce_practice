import { LightningElement } from 'lwc';

export default class LifecycleHooks extends LightningElement {
    constructor(){
        super();
        console.log("This is Constructor");
    }

    connectedCallback() {
        console.log("This is Connected CallBack");
    }

    disconnectedCallback() {
        console.log("This is Disconnected CallBack");
    }

    renderedCallback() {
        console.log("This is Rendered CallBack");
    }

    errorCallback() {
        console.log("This is Error CallBack");
    }
}