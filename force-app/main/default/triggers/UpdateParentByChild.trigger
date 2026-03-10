//Update Parent Description on update Child Description
trigger UpdateParentByChild on Contact (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        for(Contact con:trigger.new){
            if(con.AccountId != null && con.Description != trigger.oldMap.get(con.Id).Description){
                accIds.add(con.AccountId);
            }
        }
        List<Account> accToUpdate = new List<Account>();
        if(accIds.size()>0){
            Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, Description FROM Account WHERE Id IN : accIds ]);
            for(Contact con: trigger.new){
                Account acc = accMap.get(con.AccountId);
                acc.Description = con.Description;
                accToUpdate.add(acc);
            }
        }
        if(accToUpdate.size()>0){
            UPDATE accToUpdate;
        }
    }
}