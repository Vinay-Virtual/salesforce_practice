import { LightningElement } from 'lwc';

export default class ParentEvent1 extends LightningElement {

    startCounter = 0;
    counterVal = 10;

    handleInputChange(event){
        this.startCounter = event.target.value;
    }

    handleMaximizeCounter(){
        //this.counterVal = 10;
        this.template.querySelector('c-child-event1').maximizeCounter();
    }
}