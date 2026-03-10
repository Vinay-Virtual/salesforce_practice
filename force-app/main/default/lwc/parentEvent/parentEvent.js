import { LightningElement } from 'lwc';

export default class ParentEvent extends LightningElement {

    countValue = 0;

    handleDecrement(){
        this.countValue -= 1;
    }

    handleIncrement(){
        this.countValue += 1;
    }

    handleMultiply(event){
        const mulVal = event.detail;
        this.countValue *= mulVal;
    }
}