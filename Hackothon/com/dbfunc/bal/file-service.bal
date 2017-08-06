package com.dbfunc.bal;

import ballerina.lang.messages;
import ballerina.net.fs;
import ballerina.lang.strings;

@fs:configuration {
    dirURI:"C:\\ballerina\\files",
    pollingInterval:"5000",
    actionAfterProcess:"NONE"
}

service<fs> fileSystem {
    resource fileResource (message m) {
        //removing the backslash in the beginning of the url and pass it to fileread function
        fileRead(strings:replaceFirst(messages:getStringPayload(m), "/",""));
        reply m;
    }
}
