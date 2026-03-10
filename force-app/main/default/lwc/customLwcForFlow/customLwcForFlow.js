import { LightningElement, api } from 'lwc';

export default class CustomLwcForFlow extends LightningElement {
    @api accountName;
    @api accountPhone;
}