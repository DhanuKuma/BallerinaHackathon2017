package com.dbfunc.bal;

import ballerina.lang.system;
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

function fileRead (string filePath) {

    //define the file
    files:File target = {path:filePath};

    //check whether file exists
    boolean b = files:exists(target);
    system:println("file exist - " + b);

    //read file
    files:open(target, "r");
    var content, n = files:read(target, 10000);

    //convert blob to string
    string fileString = blobs:toString(content, "utf-8");

    //read one line of the txt file
    string[] arrString = strings:split(fileString, "\n");

    //get the line count
    int linesCount = arrString.length;

    while (linesCount > 0) {
        Person r1 = {};

        //extract data from each line
        string[] arrInLine = strings:split(arrString[linesCount - 1], "&&");

        r1 = {token:arrInLine[0], firstName:arrInLine[1], lastName:arrInLine[2],
                 amount:arrInLine[3], address:arrInLine[4], emailAddress:arrInLine[5], telephoneNo:arrInLine[6]};

        //call data insert function
        insertTranData(r1);

        linesCount = linesCount - 1;
    }

}