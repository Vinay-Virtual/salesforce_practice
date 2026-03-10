import { LightningElement, wire } from 'lwc';
import accList from '@salesforce/apex/LwcController.getAccList';

export default class BindWireWithFunction extends LightningElement {
    accList;
    error;
    @wire(accList)
    wiredAccounts({error, data}){
        if(data){
            this.accList = data;
            this.error = undefined;
        }
        else if(error){
            this.error = error; 
            this.accList = undefined;
        }
    }

}