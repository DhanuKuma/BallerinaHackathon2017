# BallerinaHackathon
Ballerina Hackathon 2017

Section 1
Download files from ftp location and write them in local folder using a service (FtpServer Connector).

Section 2
Read files in local folder and pass it to the file reading process using a service (File System Server Connector). 
Whenever a file downloaded it will pass it to the reading file process. 

Section 3
Read each and every file, extract data and save in the database. 
Using a restful webservice retrieve data from the database and pass data through a json array.

Section 4
Using connector through restful web service get json array and send request(tokens and messages) to the firebase through firebase connector.
When firebase received request from the connector it will send specific message to the registered devices.

List of Bugs
https://github.com/ballerinalang/ballerina/issues/3041
https://github.com/ballerinalang/ballerina/issues/3019
https://github.com/ballerinalang/ballerina/issues/3022
https://github.com/ballerinalang/ballerina/issues/3025
https://github.com/ballerinalang/ballerina/issues/3024
https://github.com/ballerinalang/plugin-intellij/issues/518
