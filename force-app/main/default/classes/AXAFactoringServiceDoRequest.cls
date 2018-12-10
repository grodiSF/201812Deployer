global with sharing class AXAFactoringServiceDoRequest {
    @InvocableMethod(label='AXA Factoring Service - Request' description='')
    global static void doRequest(List<Id> factoringReqIds) {
        doRequestInternal(factoringReqIds);
    }

    @future(callout=true)
    private static void doRequestInternal(List<Id> factoringReqIds){
        List<FactoringRequest__c> results = new List<FactoringRequest__c>();
        for(FactoringRequest__c req : [SELECT Id, CompanyName__c, FirstName__c, LastName__c, City__c, DirectorateNumber__c, Email__c, EntitledToDeductVAT__c, Fax__c, Fon__c, LegalForm__c, LegalRepresentative__c, MobileFon__c, Street__c, StreetNumber__c, VATNumber__c, Zip__c, GrossTurnover__c FROM FactoringRequest__c WHERE Id in :factoringReqIds]){
            String requestId = AXAFactoringService.request(req);
            results.add(new FactoringRequest__c(Id = req.Id, RequestId__c = requestId, Status__c = AXAFactoringService.ResultStatus.WAIT.name()));
        }
        update results;
    }
}