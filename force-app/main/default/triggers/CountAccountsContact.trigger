trigger CountAccountsContact on Contact (after insert, after update) {
    if(Trigger.isInsert){
        Set<Id> accIds = new Set<Id>();
        for(Contact con: Trigger.new){
            if(!String.isBlank(con.AccountId)){
                //accId = con.AccountId;
                accIds.add(con.AccountId);
            }
        }
        CountAccountsContactHandler.getContactCount(accIds);
    }
    
    if(Trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        for(Contact con: Trigger.new){
            if(!String.isBlank(con.AccountId)){
                //accId = con.AccountId;
                accIds.add(con.AccountId);
            }
        }
        CountAccountsContactHandler.getContactCount(accIds);
    }
}