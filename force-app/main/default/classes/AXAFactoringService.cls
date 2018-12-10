/**
  * AXA Factoring service, which wraps AXAScoringBusinessActsDe wsdl stup classes
  * @author Dirk Gronert (dirk.gronert@salesforce.com)
  **/
global with sharing class AXAFactoringService {

    global enum ReasonForDeclination{
        BAD_SCORING,
        UNKNOWN_SME,
        TURNOVER_TOO_LARGE,
        EXCLUDED_SECTOR       
    }
    global enum ResultStatus{
        OK,
        NOK,
        AMBIGUOUS,
        UNKNOWN,
        WAIT,
        ERROR,
        CONDITIONAL_ACCEPTANCE
    }

    public static String request(FactoringRequest__c req){
        return request(req.CompanyName__c, 
            req.LastName__c, 
            req.FirstName__c, 
            req.Street__c, 
            req.StreetNumber__c, 
            req.Zip__c, 
            req.City__c, 
            req.Fon__c, 
            req.Fax__c, 
            req.MobileFon__c, 
            req.Email__c, 
            req.VatNumber__c, 
            String.valueOf(req.EntitledToDeductVAT__c), 
            req.LegalForm__c, 
            req.LegalRepresentative__c, 
            String.valueOf(req.GrossTurnover__c), 
            req.DirectorateNumber__c);
    }

    /**
      *
      * @param companyName Company Name
      * @param lastName Last 
      * @param firstName
      * @param street
      * @param streeetNumber
      * @param zip
      * @param city
      * @param fon
      * @param fax
      * @param mobileFon
      * @param email
      * @param vatNumber
      * @param entitledToDeductVAT
      * @param legalForm
      * @param legalRepresentative
      * @param grossTurnover
      * @param directorateNumber
      * @return requestId 
      **/
    public static String request(String companyName, String lastName, String firstName, String street, String streetNumber, String zip, String city, String fon, String fax, String mobileFon, String email, String vatNumber, String entitledToDeductVAT, String legalForm, String legalRepresentative, String grossTurnover, String directorateNumber){
        AXAScoringBusinessActsDe.CamelIntegrationScoringImplPort sba = new AXAScoringBusinessActsDe.CamelIntegrationScoringImplPort();
        AXAScoringBusinessActsDe.requestID id = sba.SendValidateKMUDebitorRequest(
            String.isBlank(companyName)?'':companyName, 
            String.isBlank(lastName)?'':lastName, 
            String.isBlank(firstName)?'':firstName, 
            String.isBlank(street)?'':street, 
            String.isBlank(streetNumber)?'':streetNumber, 
            String.isBlank(zip)?'':zip, 
            String.isBlank(city)?'':city, 
            String.isBlank(fon)?'':fon, 
            String.isBlank(fax)?'':fax, 
            String.isBlank(mobileFon)?'':mobileFon, 
            String.isBlank(email)?'':email, 
            String.isBlank(vatNumber)?'':vatNumber, 
            String.isBlank(entitledToDeductVAT)?'':entitledToDeductVAT, 
            String.isBlank(legalForm)?'':legalForm, 
            String.isBlank(legalRepresentative)?'':legalRepresentative, 
            String.isBlank(grossTurnover)?'':grossTurnover, 
            String.isBlank(directorateNumber)?'':directorateNumber);
        return id.id;
    }

    public static AXAScoringBusinessActsDe.validatingResult validate(String requestId){
        AXAScoringBusinessActsDe.CamelIntegrationScoringImplPort sba = new AXAScoringBusinessActsDe.CamelIntegrationScoringImplPort();
        AXAScoringBusinessActsDe.validatingResult result = sba.GetValidatingKMUDebitorResult(requestId);
        return result;
    }


}