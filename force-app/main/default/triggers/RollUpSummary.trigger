/** Update the Total Number of Contacts field on the Account object whenever a new Contact is inserted or deleted */
trigger RollUpSummary on Contact (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUndelete){
            RollUpSummaryHandler.updateNumberOfContacts(Trigger.new, null);
        }

        if(Trigger.isUpdate){
            RollUpSummaryHandler.updateNumberOfContacts(Trigger.new, Trigger.oldMap);
        }

        if(Trigger.isDelete){
            RollUpSummaryHandler.updateNumberOfContacts(Trigger.old, null);
        }        
    }
    
    
    /*Set<Id> accIds = new Set<Id>();
    if(trigger.isAfter){
        if((trigger.isInsert || trigger.isUndelete)){
            for(Contact con:trigger.new){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
        if(trigger.isUpdate){
            for(Contact con:trigger.new){
                if(con.AccountId != trigger.oldMap.get(con.Id).AccountId){
                    if(trigger.oldMap.get(con.Id).AccountId != null){
                        accIds.add(trigger.oldMap.get(con.Id).AccountId);
                    }
                    if(con.AccountId != null){
                        accIds.add(con.AccountId);
                    }
                }
            }
        }
        
        if(trigger.isDelete){
            for(Contact con: trigger.old){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    List<Account> accountToUpdate = new List<Account>();
    if(accIds.size()>0){
        List<Account> accList = [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE ID IN : accIds];
        if(accList.size()>0){
            for(Account acc: accList){
                acc.Number_Of_Contacts__c = acc.Contacts.size();
                accountToUpdate.add(acc);
            }
        }
    }
    if(accountToUpdate.size()>0){
        UPDATE accountToUpdate;
    }*/
}