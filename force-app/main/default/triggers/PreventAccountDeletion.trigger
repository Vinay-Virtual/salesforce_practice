/** prevents the deletion of an Account record if it has related Opportunities */
trigger PreventAccountDeletion on Account (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        Set<Id> accIds = new Set<Id>();
        for(Account acc: Trigger.old){
            accIds.add(acc.Id);
        }

        Map<Id, Integer> oppCounts = new Map<Id, Integer>();
        List<Account> accLists = [Select Id, Name, (Select Id From Opportunities)  From Account Where Id IN: accIds];
        for(Account acc: accLists){
            oppCounts.put(acc.Id, acc.Opportunities.size());
        }

         for(Account acc: Trigger.old){
            if(oppCounts.get(acc.Id) > 0){
                acc.addError('Opportunity already exist');
            }
        }
    }
}