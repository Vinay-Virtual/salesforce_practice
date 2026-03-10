import { LightningElement, wire } from 'lwc';
import getAccList from '@salesforce/apex/LwcController.getAccList';
import updateAccountDetails from '@salesforce/apex/LwcController.updateAccountDetails'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

const columns = [
    {label : 'Account Name', fieldName: 'Name', editable: true},
    {label : 'Website', fieldName: 'Website', editable: true},
    {label : 'Phone', fieldName: 'Phone', editable: true},

]
export default class DataTableInlineEdit extends LightningElement {
    columns = columns;
    data = [];
    saveDraftValues=[];

    @wire(getAccList)
    accountData({error, data}){
        console.log('result:'+JSON.stringify(data));
        if(data){
            this.data = data;
        } else if(error){
            this.data = undefined;
        }
    }

    handleSave(event){
        const updatedFields = event.detail.draftValues;
        console.log('updatedFields==>'+JSON.stringify(updatedFields));

        updateAccountDetails({accountData: updatedFields})
            .then(result=>{
                console.log('result=>'+JSON.stringify(result));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: result,
                        message: result,
                        variant: 'success'
                    })
                );
            })
            .catch(error=>{
                console.log('Error=>'+JSON.stringify(error));
            })
    
    }

}