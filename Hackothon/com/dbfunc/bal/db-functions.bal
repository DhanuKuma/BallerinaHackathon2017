package com.dbfunc.bal;

import ballerina.data.sql;
import ballerina.lang.system;

function insertTranData (Person r1) {

    sql:ClientConnector con = conInstance();

    sql:Parameter[] params = [];
    sql:Parameter para1 = {sqlType:"integer", value:r1["token"]};
    sql:Parameter para2 = {sqlType:"varchar", value:r1["firstName"]};
    sql:Parameter para3 = {sqlType:"varchar", value:r1["lastName"]};
    sql:Parameter para4 = {sqlType:"double", value:r1["amount"]};
    sql:Parameter para5 = {sqlType:"varchar", value:r1["address"]};
    sql:Parameter para6 = {sqlType:"varchar", value:r1["emailAddress"]};
    sql:Parameter para7 = {sqlType:"varchar", value:r1["telephoneNo"]};
    params = [para1, para2, para3, para4, para5, para6, para7];
    int ret = sql:ClientConnector.update(con,
                                         "Insert into trandata (token,first_name, last_name,amount,address,telephone,email) values (?,?,?,?,?,?,?)",
                                         params);

    system:println("Inserted row count:" + ret);

    con.close();

}

function getAllRecords() (datatable ){
    sql:ClientConnector con = conInstance();
    sql:Parameter[] params = [];
    datatable dt = sql:ClientConnector.select(con,
                                              "SELECT * FROM trandata",
                                              params);

    return dt;
}