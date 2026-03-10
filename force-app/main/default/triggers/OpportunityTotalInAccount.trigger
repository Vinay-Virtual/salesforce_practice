//Sum of All Related Opp amount of an Acccount
trigger OpportunityTotalInAccount on Opportunity (after insert, after update, after delete, after undelete) {
    if(trigger.isAfter){
        Set<Id> accIds = new Set<Id>();

        if(trigger.isInsert || trigger.isUndelete){
            for(Opportunity opp : trigger.new){
                if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
            }
        }

        if(trigger.isUpdate){
            for(Opportunity opp: trigger.new){
                if(opp.AccountId != trigger.oldMap.get(opp.Id).AccountId){
                    accIds.add(opp.AccountId);
                    accIds.add(trigger.oldMap.get(opp.Id).AccountId);
                } else {
                    accIds.add(opp.AccountId);
                }
            }
        }

        if(trigger.isDelete){
            for(Opportunity opp: trigger.old){
                if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
            }
        }

        List<Account> accUpdate = new List<Account>();
        if(accIds.size()>0){
            List<AggregateResult> oppAgg =  [SELECT AccountId ids, SUM(Amount) totalSum FROM Opportunity WHERE AccountId IN : accIds GROUP BY AccountId];
            if(oppAgg.size()>0){
                for(AggregateResult agg:oppAgg){
                    Account acc = new Account();
                    acc.Id = (Id)agg.get('ids');
                    acc.Total_Amount__c = (Decimal)agg.get('totalSum');
                    accUpdate.add(acc);
                }  
            }
        } else {
            for(Id accId:accIds){
                Account acc = new Account();
                acc.Id = accId;
                acc.Total_Amount__c = 0;
                accUpdate.add(acc);
            }
        }

        if(accUpdate.size()>0){
            UPDATE accUpdate;
        }
    }
}