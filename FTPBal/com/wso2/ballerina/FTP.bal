import ballerina.net.ftp;
import ballerina.lang.messages;
import ballerina.lang.files;
import ballerina.lang.blobs;
import ballerina.lang.strings;
import ballerina.lang.system;

@ftp:configuration {
    dirURI:"ftp://dhanu:123@127.0.0.1:11/Upload",
    pollingInterval:"2000",
    actionAfterProcess:"MOVE",
    moveAfterProcess:"ftp://dhanu:123@127.0.0.1:11/Upload",
    parallel:"false",
    createMoveDir:"true"
}
service<ftp> ftpServerConnector {
    resource fileResource (message m) {
        string ftpPath = "ftp://dhanu:123@127.0.0.1:11/";
        ftp:ClientConnector c = create ftp:ClientConnector();
        string url = messages:getStringPayload(m);

        //get FileName
        string[] fileName = strings:split(url, "Upload/");
        system:println(fileName[1]);

        files:File fileDelete = {path:ftpPath + "Upload/" + fileName[1]};
        boolean fExist = ftp:ClientConnector.exists(c, fileDelete);
        system:println(fExist);

        files:File file = {path:url};
        blob txt = ftp:ClientConnector.read(c, file);
        string content = blobs:toString(txt, "UTF-8");
        system:println("Uploaded file URL : " + url);
        system:println(content);
        content = content;
        blob output = strings:toBlob(content, "UTF-8");
        files:File target = {path:"E:/Download/" + fileName[1]};
        files:open(target, "w");
        //ftp:ClientConnector.write(c, output, target);
        files:write(output, target);

        //copy file to localhost

        //delete file after move
        if (fExist) {
            ftp:ClientConnector.delete(c, fileDelete);
            system:println("File > " + fileName[1] + " deleted");
        }
        reply m;
    }
}