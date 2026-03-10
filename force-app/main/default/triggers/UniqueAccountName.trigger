/***
 * Account
 */
trigger UniqueAccountName on Account (before insert, before update) {
    if(Trigger.isBefore){
        List<String> accName = new List<String>();
        if(Trigger.isInsert){
            for(Account acc: Trigger.new){
                accName.add(acc.Name);
            }
        }

        if(Trigger.isUpdate){
            for(Account acc: Trigger.new){
                if(acc.Name != Trigger.oldMap.get(acc.Id).Name){
                    accName.add(acc.Name);
                }
            }
        }

        Map<String, Account> existingAccounts = new Map<String, Account>();
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Name IN: accName];
        if(accList.size()>0){
            for(Account acc:accList){
                existingAccounts.put(acc.name, acc);
            }

            for(Account existingAcc: Trigger.new){
                if(existingAccounts.containsKey(existingAcc.Name)){
                    existingAcc.addError('Account already have same Name!');
                }
            }
        }

    }
}