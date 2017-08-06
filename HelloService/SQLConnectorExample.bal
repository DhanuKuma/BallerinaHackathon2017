import ballerina.lang.system;
import ballerina.data.sql;

function main (string[] args) {
    runDBQueries();
}

function runDBQueries() {
    map props = {"jdbcUrl":"jdbc:mysql://localhost:3306/test_ballerina_db",
                    "username":"root", "password":""};
    sql:ClientConnector testDB = create
                                 sql:ClientConnector(props);

    sql:Parameter[] params = [];
    int ret = sql:ClientConnector.update(testDB,
                                         "create table Students(id int auto_increment,  " +
                                         "age int, name varchar(255), primary key (id))", params);
    system:println("Table creation status:" + ret);

    ret = sql:ClientConnector.update(testDB,
                                     "create procedure getCount (IN pAge int,OUT pCount int, INOUT pInt int)begin select count(*) into pCount from Students where age = pAge; select count(*) into pInt from Students where id = pInt; end", params);
    system:println("Stored proc creation status:" + ret);

    sql:Parameter para1 = {sqlType:"integer", value:8};
    sql:Parameter para2 = {sqlType:"varchar", value:"Sam"};
    params = [para1, para2];
    ret = sql:ClientConnector.update(testDB,
                                     "Insert into Students (age,name) values (?,?)",
                                     params);
    system:println("Inserted row count:" + ret);

    string[] keyColumns = [];
    string[] ids;
    ret, ids = sql:ClientConnector.updateWithGeneratedKeys
               (testDB, "Insert into Students (age,name) values (?,?)",
                params, keyColumns);
    system:println("Inserted row count:" + ret);
    system:println("Generated key:" + ids[0]);

    params = [para1];
    datatable dt = sql:ClientConnector.select(testDB,
                                              "SELECT * from Students where age = ?", params);
    var jsonRes, err = <json>dt;
    system:println(jsonRes);

    sql:Parameter p1 = {sqlType:"integer", value:10};
    sql:Parameter p2 = {sqlType:"varchar", value:"Smith"};
    sql:Parameter[] item1 = [p1, p2];

    sql:Parameter p3 = {sqlType:"integer", value:20};
    sql:Parameter p4 = {sqlType:"varchar", value:"John"};
    sql:Parameter[] item2 = [p3, p4];
    sql:Parameter[][] bPara = [item1, item2];

    int[] count = sql:ClientConnector.batchUpdate(testDB,
                                                  "Insert into Students (age,name) values (?,?)", bPara);

    system:println("Batch item 1 status:" + count[0]);
    system:println("Batch item 2 status:" + count[1]);

    sql:Parameter pAge = {sqlType:"integer", value:10};
    sql:Parameter pCount = {sqlType:"integer", direction:1};
    sql:Parameter pId = {sqlType:"integer", value:1, direction:2};
    params = [pAge, pCount, pId];

    sql:ClientConnector.call(testDB, "{call getCount(?,?,?)}", params);

    var countValue, _ = (int)pCount.value;
    system:println("Age 10 count:" + countValue);

    var idValue, _ = (int)pId.value;
    system:println("Id 1 count:" + idValue);

    sql:ClientConnector.close(testDB);
}
