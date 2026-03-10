import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import Selected_Channel from '@salesforce/messageChannel/SelectedPlayer__c';
import cricketerDetails from '@salesforce/apex/CricketerController.cricketerDetails';
import { NavigationMixin } from 'lightning/navigation';

export default class PlayerDetails extends NavigationMixin(LightningElement) {

    selectedPlayerId;
    cricketerData;

    //Show details in Player Details Card
    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        subscribe(this.messageContext, 
                Selected_Channel,
                (message)=>{
                    console.log('Subscribe Data==>'+JSON.stringify(message));
                    this.handleSelectedPlayer(message.playerId);
                }
        )
    }

    handleSelectedPlayer(playerId){
        this.selectedPlayerId = playerId;
        cricketerDetails({playerId: this.selectedPlayerId})
        .then(data=>{
            console.log('data==>'+JSON.stringify(data));
            this.cricketerData = data;
        })
        .catch(error=>{
            console.log('data==>'+JSON.stringify(error));
        })
    }

    handleNavigateToRecords(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.selectedPlayerId,
                objectApiName: 'Cricketer__c',
                actionName: 'view'
            }
        })
    }
}