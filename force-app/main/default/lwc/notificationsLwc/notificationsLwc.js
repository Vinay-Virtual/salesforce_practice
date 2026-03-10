import { LightningElement } from 'lwc';
import  lightningAlert from 'lightning/alert';
import lightningConfirm from 'lightning/confirm';
import lightningPrompt from 'lightning/prompt';

export default class NotificationsLwc extends LightningElement {
    async handleAlert(){
        await lightningAlert.open({
            message: 'This is an alert message',
            theme: 'success',
            label: 'Alert',
            variant: 'base',
            mode: 'sticky'
        }).then(() => {
            console.log('Alert Closed');
        }).catch((error) => {
            console.error('Error in Alert:', error); 
        });
    }

    async handleConfirm(){
        await lightningConfirm.open({
            message: 'Do you want to proceed?',
            theme: 'warning',
            label: 'Confirm',
            variant: 'base',
            mode: 'sticky'
        }).then((result) => {
            if (result) {
                console.log('User confirmed');
            } else {
                console.log('User cancelled');
            }
        }).catch((error) => {
            console.error('Error in Confirm:', error);
        });
    }

    async handlePrompt(){
        await lightningPrompt.open({
            message: 'Select Prompt Message',
            theme: 'warning',
            variant: 'base',
            mode: 'sticky',
            defaultValue: 'Vinay'
        }).then((result) => {
            if (result) {
                console.log('User entered: ' + result); 
            } else {
                console.log('User cancelled');
            }
        }).catch((error) => {
            console.error('Error in Prompt:', error);
        });
    }
}