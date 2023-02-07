import ballerina/http;
import ballerinax/salesforce;

function transform(AccountInfo accountInfo) returns NewAccount => {
    AccountName: accountInfo.Name,
    Id: accountInfo.Id
};

type AccountInfo record {
    record {
        string 'type;
        string url;
    } attributes;
    string Id;
    boolean IsDeleted;
    anydata MasterRecordId;
    string Name;
    string Type;
    anydata ParentId;
    anydata BillingStreet;
    anydata BillingCity;
    anydata BillingState;
    anydata BillingPostalCode;
    anydata BillingCountry;
    anydata BillingLatitude;
    anydata BillingLongitude;
    anydata BillingGeocodeAccuracy;
    anydata BillingAddress;
    anydata ShippingStreet;
    anydata ShippingCity;
    anydata ShippingState;
    anydata ShippingPostalCode;
    anydata ShippingCountry;
    anydata ShippingLatitude;
    anydata ShippingLongitude;
    anydata ShippingGeocodeAccuracy;
    anydata ShippingAddress;
    anydata Phone;
    anydata Fax;
    string AccountNumber;
    string Website;
    string PhotoUrl;
    anydata Sic;
    string Industry;
    decimal AnnualRevenue;
    anydata NumberOfEmployees;
    string Ownership;
    anydata TickerSymbol;
    anydata Description;
    string Rating;
    anydata Site;
    string OwnerId;
    string CreatedDate;
    string CreatedById;
    string LastModifiedDate;
    string LastModifiedById;
    string SystemModstamp;
    anydata LastActivityDate;
    string LastViewedDate;
    string LastReferencedDate;
    anydata Jigsaw;
    anydata JigsawCompanyId;
    string CleanStatus;
    anydata AccountSource;
    anydata DunsNumber;
    anydata Tradestyle;
    anydata NaicsCode;
    anydata NaicsDesc;
    anydata YearStarted;
    anydata SicDesc;
    anydata DandbCompanyId;
    anydata OperatingHoursId;
    anydata CustomerPriority__c;
    anydata SLA__c;
    anydata Active__c;
    anydata NumberofLocations__c;
    anydata UpsellOpportunity__c;
    anydata SLASerialNumber__c;
    anydata SLAExpirationDate__c;
};

type NewAccount record {
    string AccountName;
    string Id;
};

configurable string sfClientId = ?;
configurable string sfClientSecret = ?;
configurable string sfRefreshToken = ?;
configurable string sfRefreshUrl = ?;

salesforce:ConnectionConfig sfConfig = {
    baseUrl: "https://abcd-2c1-dev-ed.my.salesforce.com",
    auth: {
        clientId: sfClientId,
        clientSecret: sfClientSecret,
        refreshToken: sfRefreshToken,
        refreshUrl: sfRefreshUrl
    }
};

salesforce:Client salesforceEp = check new (sfConfig);

service / on new http:Listener(9090) {

    # Use salesforce connector in ballerina 
    resource function get info() returns NewAccount|error {
        json res = check salesforceEp->getAccountById("0013t00002e4USmAAM");
        AccountInfo ainfo = check res.cloneWithType(AccountInfo);
        NewAccount nacc = transform(ainfo);
        return nacc;
    }
}
