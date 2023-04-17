import ballerina/io;
import ballerina/http;
// import ballerinax/trigger.google.sheets;

configurable string pricingEndpoint = ?;

http:Client pricingClient = check new (pricingEndpoint);

type Range record {
    int columnEnd;
    int columnStart;
    int rowEnd;
    int rowStart;
};

type Source record {
};

type User record {
    string email;
    string nickname;
};

type EventData record {
    string authMode;
    Range range;
    Source 'source;
    string triggerUid;
    User user;
};

type SheetEvent record {
    string spreadsheetId;
    string spreadsheetName;
    int worksheetId;
    string worksheetName;
    string rangeUpdated;
    int startingRowPosition;
    int startingColumnPosition;
    int endRowPosition;
    int endColumnPosition;
    (int|string)[][] newValues;
    int lastRowWithContent;
    int lastColumnWithContent;
    int previousLastRow;
    string eventType;
    EventData eventData;
};

type Product record {
    string id;
    string name;
    string description;
    string 'type;
};

service / on new http:Listener(9090) {
    resource function post .(http:Caller caller, http:Request request) returns error?{
        var payload = request.getJsonPayload();

        // convert to user defined type
        if payload is json {
            SheetEvent se = check payload.cloneWithType(SheetEvent);
            io:println(getProductRecord(se.newValues));
        }        

        // call pricing service to get item price
        http:Response pricingRes = check pricingClient->/.get();
        io:println("### item price: ", pricingRes.getJsonPayload());

    }
}

function getProductRecord((int|string)[][] data) returns Product {
    Product product = {
        id: data[0][0].toString(),
        name: data[0][1].toString(),
        description: data[0][2].toString(),
        'type: data[0][3].toString()
    };
    return product;
}
