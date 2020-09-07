import 'package:couchdb/couchdb.dart';
import 'package:todolist_couchDb/Database/couchDb.dart';
import 'package:todolist_couchDb/DataModel/User.dart';

class Controller{

  static Future<Map> login(User user) async {
    if(!await DbUtil.hasDbConnection) return {};
    Map result = await DbNetAccess.getDocuments(DbUtil.DATABASE['todolist'], user.toMapWOid(), user.toList());
    if(result.isNotEmpty && result['onError'] == 'None'){
      print(await DbLocalAccess.createLocalDocuments(DbUtil.DATABASE['todolist'], result['result'][0]));
      return result;
    }
    return result;
  } 

}

class UserController{

  static Future<Map> getUser(User user) async {
    if(!await DbUtil.hasDbConnection)return {};
    return await DbNetAccess.getDocuments(DbUtil.DATABASE['todolist'], user.toMapWid(), user.toList());
  }

  static Future<Map> createUser(User user) async {
    if(!await DbUtil.hasDbConnection)return {};
    return await DbNetAccess.createDocument(DbUtil.DATABASE['todolist'], user.toMapWOid());
  }

  static Future<Map> updateUser() async {
    return {};
  }

}

class TodoController{

  static Future<Map> getTodo() async {
    return {};
  }
  
  static Future<Map> getTodos() async {
    return {};
  }

  static Future<Map> createTodos() async {
    return {};
  }

  static Future<Map> updateTodos() async {
    return {};
  }

  static Future<Map> deleteTodos() async {
    return {};
  }

}

class UtilController{

}