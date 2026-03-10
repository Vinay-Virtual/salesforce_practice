/** When an Opportunity is created or updated, check if an account with the same name as the Opportunity already exists.
 *  If it does, assign that account to the Opportunity. 
 * If it doesn’t, create a new account with the Opportunity name and assign it to the Opportunity. */

trigger OpportunityAsAccountName on Opportunity (before insert, before update) {
    Set<String> oppName = new Set<String>();
    if(trigger.isBefore){
        if(trigger.isInsert){
            for(Opportunity opp: Trigger.new){
                if(!oppName.contains(opp.Name)){
                    oppName.add(opp.Name);
                }
            }
        }
        if(trigger.isUpdate){
            for(Opportunity opp: Trigger.new){
                if(!oppName.contains(opp.Name)){
                    oppName.add(opp.Name);
                }
            }
        }
        List<Account> accList = [SELECT id, Name FROm Account WHERE Name IN: oppName];
        Map<String, Id> accNames = new Map<String, Id>();
        for(Account acc: accList){
            accNames.put(acc.Name, acc.Id);
        }

        List<Opportunity> oppToUpdate = new List<Opportunity>();
        List<Account> accToInsert = new List<Account>();
        for(Opportunity opp: Trigger.new){
            //If Account exist with same Opp Name
            if(accNames.containsKey(opp.Name)){
                if(opp.Id != accNames.get(opp.Name)){
                    //Update Opp Account Id
                    //Opportunity oppUpdate = new Opportunity();
                    //oppUpdate.Id = opp.Id;
                    opp.AccountId = accNames.get(opp.Name);
                    //oppToUpdate.add(oppUpdate);
                }
            } else {
                Account acc = new Account();
                acc.Name = opp.Name;
                accToInsert.add(acc);
            }
        }

        if(accToInsert.size() >0){
            INSERT accToInsert;
            Map<String,Id> accountInserted = new Map<String,Id>();
            for (Account acc : accToInsert) {
                accountInserted.put(acc.Name, acc.Id);  // After insert, the Id is automatically populated
            }

            for(Opportunity opp: Trigger.new){
                opp.AccountId = accountInserted.get(opp.name);
            }
        }
        
    }    

}