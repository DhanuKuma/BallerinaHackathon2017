package com.dataservice.bal;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.data.sql;
import ballerina.lang.system;


@http:configuration {basePath:"/data"}
service<http> HelloService {

    string dbUrl = "jdbc:mysql://localhost:3306/hackathon";
    string dbUsername = "root";
    string dbPassword = "";

    map props = {"jdbcUrl":dbUrl, "username":dbUsername, "password":dbPassword};
    sql:ClientConnector fileDBConnector = create
                                          sql:ClientConnector(props);

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

        sql:Parameter[] params = [];
        datatable dt = sql:ClientConnector.select(fileDBConnector,
                                                  "SELECT * FROM trandata", params);

        var jsonRes, _ = <json>dt;
        system:println(jsonRes);
        message response = {};
        messages:setJsonPayload(response, jsonRes);

        reply response;
    }

}
