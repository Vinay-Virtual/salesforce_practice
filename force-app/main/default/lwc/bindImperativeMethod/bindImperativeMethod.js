import { LightningElement } from 'lwc';
import getAccList from '@salesforce/apex/LwcController.getAccsList';

export default class BindImperativeMethod extends LightningElement {
    accList;
    error;
    handleClick(){
        getAccList()
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