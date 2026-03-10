import { LightningElement, api } from 'lwc';

export default class SampleHeadLessAction extends LightningElement {
    @api invoke(){
        console.log('SampleHeadLessAction connectedCallback');
    }
}