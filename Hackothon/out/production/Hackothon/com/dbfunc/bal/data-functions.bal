package com.dbfunc.bal;

import ballerina.lang.system;
import ballerina.data.sql;
import ballerina.lang.files;
import ballerina.lang.blobs;
import ballerina.lang.strings;

struct Person {
    any token;
    string firstName;
    string lastName;
    any amount;
    string address;
    string emailAddress;
    string telephoneNo;
    Person receiver;
}

function fileRead () {

    //define the file
    files:File target = {path:"C:\\ballerina\\files\\trandata.txt"};
    //check whether file exists
    boolean b = files:exists(target);
    system:println("file exist - " + b);
    //read file
    files:open(target, "r");
    var content, n = files:read(target, 10000);

    //convert blob to string
    string fileString = blobs:toString(content, "utf-8");
    string[] arrString = strings:split(fileString, "\n");

    int linesCount = arrString.length;
    system:println("count - " + linesCount);

    while (linesCount > 0) {
        Person r1 = {};
        string[] arrInLine = strings:split(arrString[linesCount - 1], ",");

        r1 = {token:arrInLine[0], firstName:arrInLine[1], lastName:arrInLine[2],
                 amount:arrInLine[3], address:arrInLine[4], emailAddress:arrInLine[5], telephoneNo:arrInLine[6]};

        system:println(r1);
        linesCount = linesCount - 1;
    }
}

function main (string[] args) {
    system:println("****");
}

function insertTranData () {

    sql:ClientConnector con = conInstance();
    sql:Parameter[] params = [];
    sql:Parameter para1 = {sqlType:"integer", value:1};
    sql:Parameter para2 = {sqlType:"varchar", value:"test fname"};
    sql:Parameter para3 = {sqlType:"varchar", value:"test lname"};
    sql:Parameter para4 = {sqlType:"double", value:9000.0};
    sql:Parameter para5 = {sqlType:"varchar", value:"100/1, address1, address2"};
    sql:Parameter para6 = {sqlType:"varchar", value:"+94 711234557"};
    sql:Parameter para7 = {sqlType:"varchar", value:"hackathon@test.com"};
    params = [para1, para2, para3, para4, para5, para6, para7];
    int ret = sql:ClientConnector.update(con,
                                         "Insert into trandata (token,first_name, last_name,amount,address,telephone,email) values (?,?,?,?,?,?,?)",
                                         params);

    system:println("Inserted row count:" + ret);
}
