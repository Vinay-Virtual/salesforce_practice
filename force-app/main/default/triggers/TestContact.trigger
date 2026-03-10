trigger TestContact on Contact (after insert, after update, after delete) {
    if(Trigger.isUpdate){
        system.debug('New==>'+Trigger.new);
        system.debug('New Map==>'+Trigger.newmap);
    }
	/*List<Contact> cont = [SELECT  ID FROM Contact WHERE AccountId != null];
    Integer totalCount = cont.size();
    system.debug('totalCount==>'+totalCount);*/
}