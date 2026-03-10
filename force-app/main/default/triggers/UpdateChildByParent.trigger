//Update Child Phone On Parent Phone update
trigger UpdateChildByParent on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Map<Id, Account> accMap = new Map<Id, Account>();
        for(Account acc: trigger.new){
            if(acc.Phone != trigger.oldMap.get(acc.Id).Phone){
				accMap.put(acc.Id, acc);
            }
        }
        List<Contact> conToUpdate = new List<Contact>();
        for(Contact con:[SELECT Id, Phone FROM Contact WHERE AccountId IN : accMap.keyset()]){
            con.Phone = accMap.get(con.AccountId).Phone;
            conToUpdate.add(con);
        }
        
        if(conToUpdate.size()>0){
            UPDATE conToUpdate;
        }
    }
}