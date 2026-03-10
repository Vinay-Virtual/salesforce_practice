public class ContactListController {
    @AuraEnabled
    public static List<Contact> getContactList() {
        List<Contact> conList = [SELECT Id, Name FROM Contact];
        return conList;
    }
}