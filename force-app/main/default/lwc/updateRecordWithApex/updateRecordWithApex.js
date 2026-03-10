import { LightningElement } from 'lwc';
import updateAccount from '@salesforce/apex/LwcController.updateAccount';

export default class UpdateRecordWithApex extends LightningElement {
    accountId;
    accountName;
    accountIndustry;

    handleIdChange(event){
        this.accountId = event.target.value;
    }

    handleNameChange(event){
        this.accountName = event.target.value;
    }

    handleIndustryChange(event){
        this.accountIndustry = event.target.value;
    }

    handleUpdateAccount(){
        updateAccount({accountId:this.accountId, accountName: this.accountName, accountIndustry: this.accountIndustry})
        .then(result=>{
            console.log('result=>'+JSON.stringify(result));
        })
        .catch(error=>{
            console.log('error=>'+JSON.stringify(error));
        })
    }
}