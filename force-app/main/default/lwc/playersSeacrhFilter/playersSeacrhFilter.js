import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { getObjectInfo , getPicklistValues } from "lightning/uiObjectInfoApi";
import Cricketer_OBJECT from '@salesforce/schema/Cricketer__c';
import Country_Field from '@salesforce/schema/Cricketer__c.Country__c';

export default class PlayersSeacrhFilter extends NavigationMixin(LightningElement) {
    
    picklist;
    countryOptionsValue;
    selectedCountryValue = '';
    selectedPlayerName = '';

    /**Load Drop Down Values Start*/

    // Get Object Record Type
    @wire(getObjectInfo,{objectApiName: Cricketer_OBJECT})
    objectInfo;

    //Get Field data using object record type
    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: Country_Field
    })
    countryFieldValues({ data, error }) {
        if (data) {
            console.log('data=>'+JSON.stringify(data.values));

            var arr = [];
            this.picklist = data.values;
            data.values.forEach(element => {
                arr.push({label: element.label, value: element.value});
            });
            this.countryOptionsValue = arr;
            console.log('countryOptionsValue==>'+JSON.stringify(this.countryOptionsValue));
        } else if (error) {
            console.error(error);
        }
    }
    /** Load Drop Down Values End*/

    /**Redirect to Cricketer create model */
    createCricketer(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes:{
                objectApiName: 'Cricketer__c',
                actionName: 'new'
            }
        })
    }

    /**Filter child records 
     * (Parent to Child) 
     *  */
    handleChange(event){
        this.selectedCountryValue = event.target.value;
        console.log('selecte value==>'+JSON.stringify(this.selectedCountryValue));

        this.template.querySelector('c-player-search-result').filterPlayerList(this.selectedCountryValue);
    }

    /** Show selected player name in Parent from Child 
     * (Child to Parent) 
     * */
    handleSelectedPlayer(event){
        console.log(event.detail.playerName);
        this.selectedPlayerName = event.detail.playerName;
    }

    
}