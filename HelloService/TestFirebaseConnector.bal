import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.lang.strings;

connector Firebase (string name) {
    http:ClientConnector firebaseEP = create http:ClientConnector("https://fcm.googleapis.com/fcm/send");
    action connectToFirebase (Firebase t) (message) {
        message request = {};
        messages:setHeader(request, "Authorization", "key=AAAA0LNmuUk:APA91bGtgXqlVJ4Mr07WJPb1Kzfty5jk7O24Qj6zBYF3wOW5mxX5hRmo5Tsp80UrnlVvaCGe9UjOqtxzKN76sinIwd1HoMcqJ__PYrrxvs7uUOEAFXRNxu4k_B5_g8YQLYgmXQn2ENHf");
        messages:setHeader(request, "Content-Type", "application/json");
        //json fields = {registration_ids:"eJAQ1Px2_jE:APA91bFos1Ga3Laxt44JZjxhnfo3xHRtGCVtbjWRwWi6wdxSAEOAL6LLX0YjiaxQgFEXmt_QT1GOCz8Xy6Hw94iJ0uPGmHp24jp2naUPl7gOcraJTxZkTGDWs-nH8uSwWpR5LxQ-RdKl", data:"Hello Firebase from WSO2 Hackathon VCoDeS team"};
        json userMessage = {"message": name};
        //json fields = {to:"eJAQ1Px2_jE:APA91bFos1Ga3Laxt44JZjxhnfo3xHRtGCVtbjWRwWi6wdxSAEOAL6LLX0YjiaxQgFEXmt_QT1GOCz8Xy6Hw94iJ0uPGmHp24jp2naUPl7gOcraJTxZkTGDWs-nH8uSwWpR5LxQ-RdKl", data:userMessage};
        json fields = {to:"fhCG_ly9xoo:APA91bGyQzeNInknCwtbQBUhGaRiEEsgFFjZ0NppNZIk_nh9Gamf6Q85qDjfWJnRVKH21Rj36QQ1ONSSKh3WFH8bYjOlWgRdgI6pQ7ODK0llX5ulMdkvXKoUEujflhSyu9A2fCt4dOHB", data:userMessage};
        messages:setJsonPayload(request, fields);
        message response = http:ClientConnector.post(firebaseEP, "", request);
        return response;

    }
}

connector GetMessage () {
    http:ClientConnector getMessageEP = create http:ClientConnector("http://127.0.0.1:9090/data/getAllRecords");
    action connectGetMessageService (GetMessage t) (message) {
        message request = {};
        message response = http:ClientConnector.get(getMessageEP, "", request);
        return response;
    }
}


function main(string[] args) {
    GetMessage getMessageConnector = create GetMessage();
    message dataMessage = GetMessage.connectGetMessageService(getMessageConnector);
    json dataMessageJSONResponse = messages:getJsonPayload(dataMessage);
    string name = jsons:toString(dataMessageJSONResponse);

    int l = lengthof dataMessageJSONResponse;

    int i = 0;
    while (i < l) {
        system:println(dataMessageJSONResponse[i].first_name);
        system:println(dataMessageJSONResponse[i].token);

        if(strings:contains(jsons:toString(dataMessageJSONResponse[i].token), "1006")) {
            Firebase firebaseConnector = create Firebase(jsons:toString(dataMessageJSONResponse[i].amount));
            message firebaseResponse = Firebase.connectToFirebase(firebaseConnector);
            json firebaseJSONResponse = messages:getJsonPayload(firebaseResponse);
        }


        i = i + 1;
    }


}