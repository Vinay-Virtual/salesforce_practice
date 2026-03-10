public class CustomSetting {
    /* LIST DATA*/
    public static List<CountryPhone_Code__c> getAllCountryCodes(){
        List<CountryPhone_Code__c> countryCodes = CountryPhone_Code__c.getall().values();
        for(CountryPhone_Code__c phoneCodes:countryCodes){
            system.debug(phoneCodes);
        }
		return countryCodes;
    }
    public static CountryPhone_Code__c getCountryCode(){
        CountryPhone_Code__c countryCode = CountryPhone_Code__c.getInstance('India');
        system.debug(countryCode);
        return countryCode;
    }
    
    /* Hierarchy Data*/
    public static AmazonDiscount__c getSpecialDiscount(){
         AmazonDiscount__c amazDis = AmazonDiscount__c.getValues(userinfo.getUserId());
 		system.debug(amazDis);
        return amazDis;
    }
}