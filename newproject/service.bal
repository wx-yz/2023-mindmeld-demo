import ballerina/http;
import ballerina/io;

configurable string host = "https://ws-api.toasttab.com";
configurable string clientId = ?;
configurable string secret = ?;

type Token record {
    string tokenType;
    anydata scope;
    int expiresIn;
    string accessToken;
    anydata idToken;
    anydata refreshToken;
};

type TokenResponse record {
    string \@class;
    Token token;
    string status;
};

type Order record {
    string guid;
    string 'source;
    string duration;
    string businessdate;
    string paidDate;
    string approvalStatus;
    int numberOfGuests;
};

http:Client toastLogin = check new(host);

service / on new http:Listener(9090) {

    resource function get orders() returns error? {
        string token = check getAccessToken();
        http:Request req = new;
        req.setHeader("Authorization", "Bearer " + token);
        req.setHeader("Toast-Restaurant-External-ID", "a7595311-71a2-4851-8d82-1f19b3562bf4");
        Order[] orders = check toastLogin->/orders/v2/ordersBulk(
            startDate = "2022-01-01T18:00:00.000-0000", endDate="2022-01-01T18:30:00.000-0000");
        io:println(orders);
    }

}

function getAccessToken() returns string|error {
    
    http:Request req = new;
    var payload = {
        clientId: clientId,
        clientSecret: secret,
        userAccessType: "TOAST_MACHINE_CLIENT"
    };
    req.setJsonPayload(payload);
    TokenResponse res = check toastLogin->post("/authentication/v1/authentication/login", req);
    return res.token.accessToken;
}
