public class CountAccountsContactHandler {
    public static void getContactCount(Set<Id> accIds){
        List<AggregateResult> getOpp = [SELECT COUNT(Id) totalContact FROM Contact WHERE AccountId IN: accIds GROUP BY AccountId ];
		system.debug(getOpp);
    }
}