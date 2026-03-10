trigger UpdateOneContactOfAccountActive on Contact (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        //Set<Id> accIds = new Set<Id>();
        //Set<Id> conIds = new Set<Id>();
        Map<String, String> parentIds = new Map<String, String>();
        for(Contact con:Trigger.new){
            if(con.Active__c != true){
                if(!parentIds.containsKey(con.AccountId)){
                    parentIds.put(con.AccountId, con.Id);
                }
                
                //accIds.add(con.AccountId);
                //conIds.add(con.Id);
            }
        }

        List<String> conIds = parentIds.values();
        List<Contact> conList = [Select Id, Active__c From Contact Where Id IN: conIds];
        for(Contact con:conList){
            con.Active__c = true;
        }
        if(conList.size()>0){
            UPDATE conList;
        }
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        Set<Id> conIds = new Set<Id>();
            for(Contact con: Trigger.new){
                Contact oldCon = Trigger.oldMap.get(con.Id);
                if(con.Active__c != oldCon.Active__c && con.Active__c == true){
                    accIds.add(con.AccountId);
                    conIds.add(con.Id);
                }
            }

            List<Contact> conList = [Select Id, Active__c From Contact Where AccountId IN: accIds AND Id NOT IN: conIds AND Active__c != false];
            for(COntact con:conList){
                con.Active__c = false;
            }

            if(conList.size()>0){
                UPDATE conList;
            }
    }
}