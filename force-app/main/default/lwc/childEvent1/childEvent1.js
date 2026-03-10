import { LightningElement, api } from 'lwc';

export default class ChildEvent1 extends LightningElement {

    @api counter;
    @api counterval;

    @api maximizeCounter(){
        console.log('counterval==>'+this.counterval);
        this.counter = parseInt( this.counter) + parseInt(this.counterval);
    }

}