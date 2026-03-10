/** Prevent Duplicate Account */
trigger PreventDuplicate on Account (before insert, before update) {
    if(Trigger.isBefore){
        Set<String> accNames = new Set<String>();
        if(Trigger.isInsert){
            for(Account acc:trigger.new){
                accNames.add(acc.Name);            
            }
        }

        if(Trigger.isUpdate){
            for(Account acc:trigger.new){
                if(acc.Name != Trigger.oldMap.get(acc.Id).Name){
                    accNames.add(acc.Name);            
                }
            }
        }
        
        if(accNames.size()>0){
            Set<String> existingAccName = new Set<String>();
            List<Account> accList = [SELECT Id, Name FROM Account WHERE Name IN : accNames];
            for(Account acct:accList){
                existingAccName.add(acct.Name);
            }
            
            for(Account accObj:trigger.new){
                if(existingAccName.contains(accObj.Name)){
                    accObj.Name.addError('Account Name already exist!');
                }
            }
        }
    }
}