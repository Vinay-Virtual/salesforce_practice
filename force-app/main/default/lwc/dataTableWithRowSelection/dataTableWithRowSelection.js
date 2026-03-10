import { LightningElement } from 'lwc';
import accountData from '@salesforce/apex/LwcController.accList';


const columns = [
    {label : 'Account Name', fieldName: 'Name'},
    {label : 'Website', fieldName: 'Website'},
    {label : 'Phone', fieldName: 'Phone'},
];
export default class DataTableWithRowSelection extends LightningElement {
    accountData = [];
    columns = columns;
    searchKey='';

    connectedCallback(){
        this.loadData(this.searchKey);
    }

    handleSearch(event){
        this.searchKey = event.target.value;
        console.log('searchVal=>'+this.searchKey);
        this.loadData(this.searchKey);
        
    }

    handleSelectedRow(event){
        console.log('selected');
        const rows = event.detail.selectedRows;
        console.log('rows=>'+JSON.stringify(rows));
    }

    loadData(searchVal){
        accountData({searchVal: searchVal})
        .then(result=>{
            console.log('result:'+JSON.stringify(result));
            this.accountData = result;
        })
        .catch(error=>{
            console.log('error:'+JSON.stringify(error));
        })
    }
}