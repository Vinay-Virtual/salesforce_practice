//Show error on add and update, if a account already have 2 contact 
trigger RestrictToAddContactOnAccount on Contact (before insert, before update) {
    Set<Id> accIds = new Set<Id>();
    if(trigger.isBefore){
        if(trigger.isInsert){
            for(Contact con:trigger.new){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
        if(trigger.isUpdate){
            for(Contact con:trigger.new){
                if(con.AccountId != null && con.AccountId != trigger.oldMap.get(con.Id).AccountId){
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    if(accIds.size()>0){
        Map<Id, Integer> contactCount = new Map<Id, Integer>();
        List<AggregateResult> aggCount = [SELECT AccountId, count(Id) totalContact FROM Contact WHERE AccountId IN : accIds group by AccountId];
        if(aggCount.size()>0){
            for(AggregateResult count: aggCount){
                if(count.get('AccountId') != null){
                    contactCount.put((Id)count.get('AccountId'),(Integer)count.get('totalContact'));
                }
            }
        }
        if(contactCount.size()>0){
            for(Contact con:trigger.new){
                if(con.AccountId != null && contactCount.get('con.AccountId') >= 2){
                    con.addError('You can not add/update more records as 2 contacts are already there in an Account');
                }
            }
        }
    }
}