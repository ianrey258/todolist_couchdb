class User {
    User({
        this.id,
        this.rev,
        this.docType,
        this.username,
        this.password,
    });

    String docType;
    String id;
    String rev;
    String username;
    String password;

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        rev: json["_rev"],
        docType: json["docType"],
        username: json["username"],
        password: json["password"],
    );

    Map<String, String> toMapWid() => {
        "_id": id,
        "_rev": rev,
        "docType":docType,
        "username": username,
        "password": password,
    };

    Map<String, String> toMapWOid() => {
        "docType":docType,
        "username": username,
        "password": password,
    };

    List<String> toList()=>["_id","_rev","docType","username","password"];
}

class UserData {
    UserData({
        this.id,
        this.rev,
        this.docType,
        this.userId,
        this.name,
        this.todo,
        this.datetime,
        this.event,
    });

    String id;
    String rev;
    String docType;
    String userId;
    String name;
    String todo;
    String datetime;
    String event;

    factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        rev: json["_rev"],
        docType: json["docType"],
        userId: json["userId"],
        name: json["name"],
        todo: json["todo"],
        datetime: json["datetime"],
        event: json["event"],
    );

    Map<String, dynamic> toMapWid() => {
        "_id": id,
        "_rev": rev,
        "docType":docType,
        "userId": userId,
        "name": name,
        "todo": todo,
        "datetime": datetime,
        "event": event,
    };

    Map<String, dynamic> toMapWOid() => {
        "docType":docType,
        "userId": userId,
        "name": name,
        "todo": todo,
        "datetime": datetime,
        "event": event,
    };

    List<String> toList()=>["_id","_rev","docType","userId","name","todo","datetime","event"];
}