public  class HttpClassController {
    @AuraEnabled
    public static string getHttpData(){
       Http h = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('callout:NewTest');
       req.setMethod('GET');
       HttpResponse res = h.send(req);
       system.debug(res.getBody());
       return res.getBody();
    }
}