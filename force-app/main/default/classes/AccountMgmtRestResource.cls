@RestResource(urlMapping = '/accountmgmts/')
global class AccountMgmtRestResource {
	@httpGet
    global static AccountWrapper getAccountDetails(){
        Set<Id> accIds = new Set<Id>();
        Map<String, String> paramsMap = RestContext.request.params;
        String industry = paramsMap.get('Industry');
        List<Account> getAcc = [SELECT Id, Name, Industry FROM Account WHERE Industry =: industry LIMIT 10];
        for(Account acc: getAcc){
            accIds.add(acc.Id);
        }
        List<Contact> conList = [SELECT Id, firstname, lastname, email FROM Contact WHERE accountId IN: accIds];
        List<Case> caseList = [SELECT Id, priority, subject FROM Case WHERE accountId IN: accIds];
        
        AccountWrapper accWrapper = new AccountWrapper();
        accWrapper.accList = getAcc;
        accWrapper.conList = conList;
        accWrapper.caseList = caseList;
        return accWrapper;
    }
    
    @HttpPost
    global static String createAccountAndContact(AccountInformation information){
        Account accRecord =  information.accountRecord;
        Contact conRecord =  information.contactRecord;
        try{
            INSERT accRecord;
            conRecord.accountId = accRecord.Id;
            INSERT conRecord;
            return 'Created successfully!';
        } catch(exception ex){
            return ex.getMessage();
        }
    }
    
    
    //WRAPPER CLASS FOR GET Method to return List of different Objects
    global class AccountWrapper{
        global List<Account> accList;
        global List<Contact> conList;
        global List<Case> caseList;
    }
    
    global class AccountInformation{
        global Account accountRecord{get;set;}
        global Contact contactRecord{get;set;}
    }
}