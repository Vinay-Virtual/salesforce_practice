/** PreventDuplicateEmailLeads Handler */
public with sharing class PreventDuplicateEmailLeadsHandler {
    public static void checkDuplicates(List<Lead> leadList, Map<Id, Lead> oldMap){
        Set<String> emailLists = new Set<String>();
        for(Lead lead: leadList){
            if(lead.Email != null){
                if(oldMap == null){
                   emailLists.add(lead.Email);
                } else if(lead.Email != oldMap.get(lead.Id).Email){
                    emailLists.add(lead.Email);
                }                
            }
        }

        Set<String> emailExists = new Set<String>();
        List<Lead> leadData = [Select Id, Email From Lead Where Email IN: emailLists];
        for(Lead lead:leadData){
            emailExists.add(lead.Email);
        }

        for(Lead lead: leadList){
            if(emailExists.contains(lead.Email)){
                lead.addError('Lead already exist with same Email!');
            }
        }
    }
}