import ballerina.net.http;
import ballerina.lang.messages;

@http:configuration {basePath:"/hello"}
service<http> HelloService {

    @http:GET {}
    @http:Path {value:"/"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "Hello World !!!");
        reply response;
    }
}
