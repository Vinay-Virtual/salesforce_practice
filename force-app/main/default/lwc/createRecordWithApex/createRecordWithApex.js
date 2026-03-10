import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/LWCController.createAccount';
export default class CreateRecordWithApex extends LightningElement {
    accountIds;
    accountName;
    accountIndustry;

    handleNameChange(event){
        this.accountName = event.target.value; 
    }

    handleIndustryChange(event){
        this.accountIndustry = event.target.value;
    }

    handleCreateAccount(){
        createAccount({accountName: this.accountName, accountIndustry: this.accountIndustry})
        .then(result=>{
            this.accountIds = result[0].Id;
            alert('Account created');
        })
        .catch(error=>{
            console.log('error=>'+JSON.stringify(error));
        })
    }
}