package com.dbfunc.bal;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.data.sql;
import ballerina.lang.system;


@http:configuration {basePath:"/data"}
service<http> HelloService {

    sql:ClientConnector con = conInstance();

    @http:GET {}
    @http:Path {value:"/"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "Hello World !!!");
        reply response;
    }

    @http:GET {}
    @http:Path {value:"/getAllRecords"}
    resource getAllRecords (message m) {
        datatable dt = getAllRecords();
        var jsonRes, _ = <json>dt;
        system:println(jsonRes);
        message response = {};
        messages:setJsonPayload(response, jsonRes);

        reply response;
    }

}
