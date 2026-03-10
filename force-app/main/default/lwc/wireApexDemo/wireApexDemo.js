import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { getRecord } from 'lightning/uiRecordApi';

export default class WireApexDemo extends LightningElement {
  @api recordId;

  @wire(getRecord,{recordId:'$recordId',fields:'Account.Name'})
  records;

  @wire(getContacts,{accId:'$recordId'})
  contacts;

  get name(){
    return this.records.data.fields.Name.value;
  }

}