import { LightningElement } from 'lwc';

export default class ChildEvent extends LightningElement {

    handleSubtract(){
        this.dispatchEvent(new CustomEvent('subtract'));
    }

    handleAdd(){
        this.dispatchEvent(new CustomEvent('add'));
    }

    handleMultiply(event){
        const value = event.target.value;
        this.dispatchEvent(new CustomEvent('multiply',{'detail': value}))
    }
}