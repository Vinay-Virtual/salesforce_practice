import { LightningElement } from 'lwc';
import accountData from '@salesforce/apex/LwcController.accList';

const actions = [
    {label: 'View', name:'view'},
    {label:'Delete', name:'delete'}
];

const columns = [
    {label : 'Account Name', fieldName: 'Name'},
    {label : 'Phone', fieldName: 'Phone'},
    {
        type: 'action',
        typeAttributes: {rowActions: actions}
    }
];
export default class DataTableWithRowAction extends LightningElement {
    accountData = [];
    columns = columns;
    searchKey='';

    connectedCallback(){
        this.loadData(this.searchKey);
    }

    handleRowAction(event){
        console.log('selected');
        const action = event.detail.action;
        const row = event.detail.row;
        console.log('action=>'+JSON.stringify(action));
        console.log('row=>'+JSON.stringify(row));
        switch(action.name){
            case 'view':
                console.log('View Data=>'+JSON.stringify(row));
                break;
            case 'delete':
                const rows = this.accountData;
                const rowIndex = rows.indexOf(row);
                rows.splice(rowIndex, 1);
                this.accountData = rows;
                break;


        }
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