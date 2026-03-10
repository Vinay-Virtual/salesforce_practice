public with sharing class CricketerController {
    
    @AuraEnabled(cacheable = true)
    public static List<Cricketer__c> getCricketerdata(String cricketerCountry){
        String sql = 'SELECT Id, Name, Runs__c,Age__c, Image_Url__c,Image__c FROM Cricketer__c ';
        if(cricketerCountry != ''){
            sql += 'WHERE Country__c =: cricketerCountry';
        }
        List<Cricketer__c> cricketerList = Database.query(sql);
        system.debug('cricketerList==>'+cricketerList);
        return cricketerList;
    }

    @AuraEnabled
    public static Cricketer__c cricketerDetails(String playerId){
        Cricketer__c crickData = [SELECT Id, Name, Runs__c,Age__c, Image_Url__c,Image__c, Country__c FROM Cricketer__c WHERE Id =: playerId];
        return crickData;
    }
}