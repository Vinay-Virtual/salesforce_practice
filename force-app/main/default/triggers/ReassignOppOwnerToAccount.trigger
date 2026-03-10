/**When an Opportunity is marked as "Closed Won," the owner needs to be reassigned to the Account Owner. */
trigger ReassignOppOwnerToAccount on Opportunity (after insert, after update) {
    if(trigger.isAfter){
        Map<String, String> oppData = new Map<String, String>();
        if(trigger.isInsert){
            for(Opportunity opp: Trigger.new){
                if(opp.StageName == 'Closed Won' && opp.AccountId != null){
                    oppData.put(opp.AccountId, opp.OwnerId);
                }
            }
        }
        if(trigger.isUpdate){
            for(Opportunity opp: Trigger.new){
                if(opp.StageName == 'Closed Won' && opp.AccountId != null && opp.StageName != trigger.oldMap.get(opp.Id).StageName){
                    oppData.put(opp.AccountId, opp.OwnerId);
                }
            }
        }

        List<Account> accLists = [SELECT Id, OwnerId FROm Account WHERE Id IN: oppData.keySet()];
        for(Account acc: accLists){
            if(acc.OwnerId != oppData.get(acc.Id)){
                acc.OwnerId = oppData.get(acc.Id);
            }
        }
        UPDATE accLists;
    }
}