import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
@display {
	label: "NewComp",
	id: "NewComp-49c69c44-b8a8-4b17-9453-100bf20dffdb"
}
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }
}
