import { LightningElement } from 'lwc';

export default class BindHTMLDynamic extends LightningElement {
    myValue = "Salesforce Dynamic";
    handleChange(event) {
        this.myValue = event.target.value;
    }
}