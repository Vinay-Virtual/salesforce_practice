trigger AccountAddressTrigger on Account (before insert, before update) {
    for(Account acc: Trigger.New){
        if(acc.Match_Billing_Address__c == true) {
            acc.Billing_Postal_Code__c = acc.Shipping_Postal_Code__c;
        }
    }
}