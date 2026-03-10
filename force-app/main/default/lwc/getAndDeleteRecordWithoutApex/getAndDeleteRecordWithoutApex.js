import { LightningElement, wire } from 'lwc';
import {getRecord, deleteRecord} from 'lightning/uiRecordApi';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import ACCOUNT_OWNER from '@salesforce/schema/Account.Owner.Name';

const FIELDS = [ACCOUNT_NAME,ACCOUNT_INDUSTRY,ACCOUNT_PHONE,ACCOUNT_OWNER];

export default class GetAndDeleteRecordWithoutApex extends LightningElement {
    accountId;
    accountName;
    industry;
    phone;
    owner;
    accountDetails;


    @wire(getRecord,{recordId: '001J100000QBuG5IAL', fields: FIELDS})
    wireAccount({error, data}){
        if(error){
            console.log('error:'+JSON.stringify(error));
        }
        else if(data) {
            console.log('data:'+JSON.stringify(data));
            this.accountDetails = data;
            this.accountId = data.id;
            this.accountName = data.fields.Name.value;
            this.industry = data.fields.Industry.value;
            this.phone = data.fields.Phone.value;
            this.owner = data.fields.Owner.displayValue;
        }
    }

    deleteAccount(){
        console.log(this.accountId)
        deleteRecord(this.accountId)
        .then(result=>{
            alert('Account Deleted Successfully!');
        })
        .catch(error=>{
            console.log('Error:'+JSON.stringify(error));
        })
    }
}