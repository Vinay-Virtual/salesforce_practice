import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';


// Import Object Fields Trhough String
export default class WireAdapterDemo extends LightningElement { 
  @api recordId;

  @wire(getRecord, {recordId:'$recordId', fields:['Account.Name', 'Account.Phone']})
  record;

  get name(){
    return this.record.data ? getFieldValue(this.record.data,'Account.Name') : '';
    //return this.record.data.fields.Name.value; //Set if condition in html
  }
  get phone(){
    return this.record.data ? getFieldValue(this.record.data,'Account.Phone') : '';
    //return this.record.data.fields.Phone.value;
  }
}

/***  IMPORT Reference To Fields 
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class WireAdapterDemo extends LightningElement {

  @api recordId;

  @wire(getRecord,{recordId: '$recordId',fields: [NAME_FIELD,PHONE_FIELD]})
  record;  //Properties with data and Error

  get name(){
    return this.record.data ? getFieldValue(this.record.data,NAME_FIELD) : '';
  }
  get phone(){
    return this.record.data ? getFieldValue(this.record.data,PHONE_FIELD) : '';
  }
}*/