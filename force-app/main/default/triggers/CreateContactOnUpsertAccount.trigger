/***
 * Create Contact on Insert/Update Account, when Create_Contact_Checkbox__c is checked
 * Set Account Phone into Contact
 */
trigger CreateContactOnUpsertAccount on Account (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            List<Contact> conToInsert = new List<Contact>();
            for(Account acc: Trigger.new){
                if(acc.Create_Contact_Checkbox__c && acc.Create_Contact_Checkbox__c != Trigger.oldMap.get(acc.Id).Create_Contact_Checkbox__c){
                    Contact con = new Contact();
                    con.FirstName = acc.Name;
                    con.LastName = 'Contact';
                    con.Phone = acc.Phone;
                    con.AccountId = acc.Id;
                    conToInsert.add(con);
                }
            }
            if(conToInsert.size()>0){
                Insert conToInsert;
            }
        }
    }
}