import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class CreateRecordWithoutApex extends LightningElement {
    accountId;
    name = '';

    handlenameChange(event){
        this.name = event.target.value;
        console.log(this.name);
    }

    handleCreateAccount(){
        console.log(this.name)
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        const recordInput = {apiName :ACCOUNT_OBJECT.objectApiName, fields};

        createRecord(recordInput)
        .then(account=>{
            console.log(account.id);
            this.accountId = account.id;
        })
        .catch(error=>{
            console.log('error==>'+error);
        })
    }
}