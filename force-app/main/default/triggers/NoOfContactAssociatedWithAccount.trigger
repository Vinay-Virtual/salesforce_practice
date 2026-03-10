/***
 * No of Contact associated with each Accounts and update Number_of_Contacts__c field in Account
 */
trigger NoOfContactAssociatedWithAccount on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accIds = new Set<Id>();
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUndelete){
            for(Contact con: Trigger.new){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }

        if(Trigger.isUpdate){
            for(Contact con: Trigger.new){
                if(con.AccountId != Trigger.oldMap.get(con.Id).AccountId){
                    accIds.add(con.AccountId);
                    accIds.add(Trigger.oldMap.get(con.Id).AccountId);
                } else {
                    accIds.add(con.AccountId);
                }
            }
        }

        if(Trigger.isDelete){
            for(Contact con: Trigger.old){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }

        List<Account> accToUpdate = new List<Account>();
        List<Account> accList = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) FROm Account WHERE Id IN: accIds];
        if(accList.size() > 0){
            for(Account  acc: accList){
                acc.Number_of_Contacts__c = acc.Contacts.size();
                accToUpdate.add(acc);
            }
            if(accToUpdate.size()>0){
                try {
                    UPDATE accToUpdate;
                } catch (DMLException e) {
                    system.debug(' An error has occured '+ e.getMessage());
                }
            }
        }
    }
}