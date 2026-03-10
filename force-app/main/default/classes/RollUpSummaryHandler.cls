/** Roll Up summary Trigger Handler Class */
public with sharing class RollUpSummaryHandler {
    public static void updateNumberOfContacts(List<Contact> conList, Map<Id, Contact> oldMap){
        Set<Id> accIds = new Set<Id>();
        for(Contact con: conList){
            if(oldMap == null){  //For Insert, Delete and Undelete
                if(con.AccountId != null){
                    accIds.add(con.AccountId);                    
                }
            } else { //For Update
                if(con.AccountId != null && con.AccountId != oldMap.get(con.Id).AccountId){
                    accIds.add(con.AccountId);
                    accIds.add(oldMap.get(con.Id).AccountId);
                } else {
                    accIds.add(con.AccountId);
                }
            }             
        }

        List<Account> accToUpdate = new List<Account>();
        if(accIds.size()>0){  
            List<Account> accLists = [Select Id, Number_Of_Contacts__c, (Select Id From Contacts) From Account Where Id IN: accIds];
            if(accLists.size()>0){
                for(Account acc: accLists){
                    acc.Number_Of_Contacts__c = acc.Contacts.size();
                    accToUpdate.add(acc);
                }
            }
        }
        if(accToUpdate.size()>0){
            Update accToUpdate;
        }
    }
}