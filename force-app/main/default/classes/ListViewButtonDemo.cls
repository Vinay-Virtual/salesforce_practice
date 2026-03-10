public class ListViewButtonDemo {
    public List<Opportunity> opportunities{get;private set;}
    public String MstrId{get;set;}

    public ListViewButtonDemo(ApexPages.StandardSetController stdSetController){
         MstrId = ApexPages.currentPage().getParameters().get('id'); 
        system.debug('MstrId==>'+MstrId);

        // Returns all selected records
        opportunities = (List<Opportunity>) stdSetController.getSelected();
    }
    
    public PageReference save(){
        // Some fancy stuff here.
        try{
         update opportunities;
        } catch(Exception e){
            System.debug('Exception: ' + e);
        }
        return null;
    }
}