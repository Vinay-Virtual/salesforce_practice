public class CustomMetadata {
    public static List<Country_Code__mdt> getCountryCodes(){
        List<Country_Code__mdt> codes = [SELECT Label,Phone_Code__c FROM Country_Code__mdt];
        for(Country_Code__mdt code:codes){
            system.debug(code);
        }
        return codes;
    }
}