import ballerina/io;
import ballerinax/trigger.google.sheets;

configurable sheets:ListenerConfig userInput = {
    spreadsheetId: "1B5gF5YFIHEtPoagbtzmF0JjZWN0CPAcgL9j-1vV17Dw"
};

listener sheets:Listener sheetListener = new (userInput);

service sheets:SheetRowService on sheetListener {

    remote function onAppendRow(sheets:GSheetEvent payload) returns error? {
        json? eventData = payload?.eventData;
        io:println(eventData);
        // Write your logic here.....
    }

    remote function onUpdateRow(sheets:GSheetEvent payload) returns error? {
        json? eventData = payload?.eventData;
        io:println(eventData);
        // Write your logic here.....
    }
}
