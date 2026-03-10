import { LightningElement, wire, api } from 'lwc';
import CricketerData from '@salesforce/apex/CricketerController.getCricketerdata';
import { publish, MessageContext } from 'lightning/messageService';
import Selected_Channel from '@salesforce/messageChannel/SelectedPlayer__c';

export default class PlayerSearchResult extends LightningElement {

    cricketerCountry = '';
    cricketerData;
    selectedPlayerId;
    selectedPlayerName;

   

    /** Load all cricketers records */
    @wire(CricketerData,{cricketerCountry: '$cricketerCountry'})
    CricketerData({data, error}){
        if(error){
            console.log('error=>'+JSON.stringify(error));
        }
        else {
            console.log('data==>'+JSON.stringify(data));
            this.cricketerData = data;
        }
    }

     //Call from Parent to change country filter
    @api filterPlayerList(selectedCountry){
        console.log('selectedCountry==>'+selectedCountry);
        this.cricketerCountry = selectedCountry;
    }

    /** Message Channel
     * Publish
     */
     @wire(MessageContext)
    messageContext;

    handleClickPlayerCard(event){
        console.log('Name==>'+event.currentTarget.dataset.name)
        this.selectedPlayerId = event.currentTarget.dataset.id;
        this.selectedPlayerName = event.currentTarget.dataset.name;

        //Remove from selected div
        let checkedSelected = this.template.querySelectorAll('.selected');
        if(checkedSelected.length>0){
            this.removeSelected();
        }

        //Assign to new div
        let assignSelected = this.template.querySelector(`[data-id="${this.selectedPlayerId}"]`);
        if(assignSelected){
            assignSelected.className = 'title_wrapper selected';
        }

        /***Show Player Name on parent
         * Child To parent
         */
         
        this.dispatchEvent(new CustomEvent('select',
            {
                detail:{
                    playerName: this.selectedPlayerName
                }
            }
        ))
        /**Publish channel */
        const payLoad = {playerId: this.selectedPlayerId};
        publish(this.messageContext, Selected_Channel, payLoad );
    }

    removeSelected(){
        this.template.querySelectorAll('.selected')[0].classList.remove('selected');
    }

   
}