import { LightningElement } from 'lwc';
import findAccData from '@salesforce/apex/LwcController.findAccData';

export default class BindImperativeWithParams extends LightningElement {
    searchKey;
    accList;
    error;

    handleChange(event){
        this.searchKey = event.target.value;
    }
    handleReset(){
        this.searchKey = '';
        this.accList = '';
    }
    handleClick(){
        findAccData({keyword: this.searchKey})
            .then((result)=> {
                this.accList = result;
                this.error = undefined;
            })
            .catch((error)=>{
                this.error = error;
                this.accList = undefined;        
            })        
    }

}