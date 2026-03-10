/**  Email on the Lead object is unique across all Lead records */
trigger PreventDuplicateEmailLeads on Lead (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            PreventDuplicateEmailLeadsHandler.checkDuplicates(Trigger.new, null);
        }
        if(Trigger.isBefore){
            PreventDuplicateEmailLeadsHandler.checkDuplicates(Trigger.new, Trigger.oldMap);
        }
    }
}