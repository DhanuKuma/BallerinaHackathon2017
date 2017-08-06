package com.dbfunc.bal;

import ballerina.data.sql;
import ballerina.lang.system;
import ballerina.lang.errors;

function conInstance() (sql:ClientConnector){

    string dbUrl = "jdbc:mysql://localhost:3306/hackathon";
    string dbUsername = "root";
    string dbPassword = "";

    map props = {"jdbcUrl":dbUrl,
                    "username":dbUsername, "password":dbPassword};

    try {
        sql:ClientConnector sqlDB = create
                                    sql:ClientConnector(props);
        system:println("connected....");

        return sqlDB;

    } catch (errors:Error  e) {
        system:println(e);
    }

    return null;

}