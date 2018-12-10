public with sharing class AXAFactoringServiceDoValidation {
    @AuraEnabled
    public static void doValidation(String requestId) {
        doValidationInternal(new List<String>{requestId});
    }


    @InvocableMethod(label='AXA Factoring Service - Validation' description='')
    public static void doValidation(List<String> requestIds) {
        doValidationInternal(requestIds);
    }

    @future(callout=true)
    private static void doValidationInternal(List<String> requestIds){
        List<FactoringResponse__c> results = new List<FactoringResponse__c>();
        List<FactoringRequest__c> requests = new List<FactoringRequest__c>();
        for(FactoringRequest__c req : [SELECT Id, Contact__c, Account__c, RequestId__c FROM FactoringRequest__c WHERE RequestID__c in :requestIds OR Id in :requestIds]){
            AXAScoringBusinessActsDe.validatingResult result = AXAFactoringService.validate(req.RequestId__c);
            results.add(
                new FactoringResponse__c(
                    FactoringRequest__c = req.Id, 
                    Contact__c = req.Contact__c, 
                    Account__c = req.Account__c,
                    Condition__c = result.condition,
                    PurchaseLimit__c = result.purchaseLimit,
                    ReasonForDeclination__c = result.reasonForDeclination,
                    Status__c = result.status));
            requests.add(
                new FactoringRequest__c(Id = req.Id, Status__c = result.status));
        }
        insert results;
        update requests;
    }
}