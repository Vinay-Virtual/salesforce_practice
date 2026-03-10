public with sharing class LwcController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccList(){
         return [SELECT Id, Name, Website, Phone FROM Account ORDER BY CreatedDate desc LIMIT 10];
    }

    @AuraEnabled
    public static List<Account> getAccsList(){
         return [SELECT Id, Name FROM Account ORDER BY CreatedDate desc LIMIT 10];
    }

    @AuraEnabled
    public static List<Account> findAccData(String keyword){
        String key = '%'+keyword+'%';
        return [SELECT Id, Name FROM Account WHERE Name LIKE :key ORDER BY CreatedDate desc LIMIT 10];
    }

    /** Create Record */
    @AUraEnabled
    public static List<Account> createAccount(String accountName, String accountIndustry){
        List<Account> accToInsert = new List<Account>();
        if(accountName != null){
            Account acc = new Account();
            acc.Name = accountName;
            acc.Industry = accountIndustry;
            accToInsert.add(acc);
        }

        if(accToInsert.size()>0){
            INSERT accToInsert;
            return accToInsert;
        }
        return null;
    }

    /** Update Record */
    @AuraEnabled
    public static List<Account> updateAccount(String accountId, String accountName, String accountIndustry){
        if(accountId != null){
            List<Account> accDetails = [SELECT Id FROM Account WHERE Id =: accountId];
            if(accDetails.size()>0){
                for(Account acc:accDetails){
                    acc.Id = accountId;
                    acc.Name = accountName;
                    acc.Industry = accountIndustry;
                }
                UPDATE accDetails;
                return accDetails;
            }
            return null;
        }
        return null;
    }

    @AuraEnabled
    public static string updateAccountDetails(Object accountData){
        System.debug(accountData);

       system.debug('accData json=>'+JSON.serialize(accountData));

        List<Account> accData = (List<Account>) JSON.deserialize(JSON.serialize(accountData), List<Account>.class);
        system.debug('accData=>'+accData);
        if(!accData.isEmpty()){
            UPDATE accData;
            return 'Success';
        }
        
        return 'failed';
    }

    /** Datatable with Row Selection */
    @AuraEnabled
    public static List<Account> accList(String searchVal){
        String query = 'SELECT Id, Name, Phone, Website FROM Account ';
        if(searchVal !='' && searchVal != null){
           String key = '%'+searchVal+'%';
           query += 'Where Name LIKE: key';
        }
        query += '  ORDER BY CreatedDate desc LIMIT 10';
        system.debug('query=>'+query);
        List<Account> result = Database.query(query);
        return result;
    }
    
}