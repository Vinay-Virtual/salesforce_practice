//On Account Update, update related opp stage 
trigger UpdateOppStageOnAccountUpdate on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        for(Account acc:trigger.new){
            accIds.add(acc.Id);
        }

        if(accIds.size()>0){
            Date day30 = date.today()-30;
            List<Opportunity> oppData = [SELECT id, StageName,CloseDate FROM Opportunity WHERE AccountId IN : accIds AND StageName != 'Closed Won' AND CloseDate <: day30 ];
            if(oppData.size()>0){
                List<Opportunity> oppUpdate = new List<Opportunity>();
                for(Opportunity opp: oppData){
                    if(opp.StageName != 'Closed Lost'){
                        opp.StageName = 'Closed Lost';
                        oppUpdate.add(opp);
                    }
                }
                if(oppUpdate.size()>0){
                    UPDATE oppUpdate;
                }
            }
        }
    }
}