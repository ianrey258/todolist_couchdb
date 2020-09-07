import 'package:couchdb/couchdb.dart';
import 'dart:math';

class DbUtil{

  static const DATABASE = {
    'todolist':'todolist'
  };

  static const DOCTYPE = {
    'user_todo':'user_todo',
    'user_auth':'user_auth'
  };

  static Future<CouchDbClient> get _couchClient async {
    return CouchDbClient(username: 'admin',password: 'admin',host: '192.168.1.117');
  }

  static Future<Databases> get databases async {
    return Databases(await _couchClient);
  }

  static Future<Documents> get documents async {
    return Documents(await _couchClient);
  }

  static Future<LocalDocuments> get localDocuments async {
    return LocalDocuments(await _couchClient);
  }

  static Future<String> get uuids async {
    List genid = [];
    String sampleSplit = 'reserve_216565';
    print(sampleSplit.indexOf('reserve'));
    await hasDbConnection ? await _couchClient.then((value) => value.get('/_uuids').then((value) => value.json.forEach((key, value) {genid = value;}))) 
                          : genid.add('reserve'+'_'+Random().nextInt(50000).toString());
    return genid[0];
  }

  static Future<bool> get hasDbConnection async {
    try{
      DatabasesResponse result = await databases.then((value)=>value.allDocs(DATABASE['todolist']));
      if( result.rows.length != 0)return true;
    }catch(e){
      return false;
    }
    return false;
  }

  static Future<Map> getResult(result,{onError = 'None'}) async {
    return {'result' : result,'onError' : onError};
  }

}

class DbNetAccess{

  static Future<String> syncDatabase() async {
    try{
      final DatabasesResponse databasesResponse = await DbUtil.databases.then((value) => value.synchronizeShards(DbUtil.DATABASE['todolist']));
      return databasesResponse.toString();
    } catch(e){
      print(e);
      return 'Error Syncing';
    }
  }

  //get Database Documents or Document
  static Future<Map> getDocuments(String database,Map selector,List fields)async{
    try{
      final DatabasesResponse databasesResponse = await DbUtil.databases.then((value) => value.find(database,selector,fields: fields));
      print(databasesResponse.docs.toString());
      return DbUtil.getResult(databasesResponse.docs);
    }catch(e){
      print(e);
      return DbUtil.getResult(e,onError: "\nError Get Documents");
    }
  }

  //create Document
  static Future<Map> createDocument(String database,Map data) async {
    try{
      print(data.toString());
      String id = await DbUtil.uuids;
      final DocumentsResponse documentsResponse = await DbUtil.documents.then((value) => value.uploadAttachment(database, id, '', data));
      return DbUtil.getResult(documentsResponse.doc);
    } catch(e){
      print(e);
      return DbUtil.getResult(e,onError: "\nError Create Document");
    }
  }

  //update Document
  static Future<Map> updateDocument(String database,Map fullData,Map data) async {
    try{  
      final DocumentsResponse documentsResponse = await DbUtil.documents.then((value) => value.uploadAttachment(database, fullData['_id'], '', data,rev: fullData['_rev']),);
      return DbUtil.getResult(documentsResponse.doc);
    } catch(e){
      print(e);
      return DbUtil.getResult(e,onError: "\nError Update Document");
    }
  }

  //delete Document
  static Future<Map> deleteDocument(String database,Map data) async {
    try{
      final DocumentsResponse documentsResponse = await DbUtil.documents.then((value) => value.deleteAttachment(database, data['_id'], '', rev: '_rev'));
      return DbUtil.getResult(documentsResponse.doc);
    }catch(e){
      print(e);
      return DbUtil.getResult(e,onError: "\nError Delete Document");
    }
  }

}

class DbLocalAccess{

  //get LocalDocument
  static Future<Map> getLocalDocument(String database,String docId) async {
    try{
      final LocalDocumentsResponse localDocumentsResponse = await DbUtil.localDocuments.then((value) => value.localDoc(database,docId));
      return await DbUtil.getResult(localDocumentsResponse.doc);
    }catch(e){
      print(e);
      return await DbUtil.getResult(e,onError: "\nError Get Document on LocalDocument");
    }
  }

  //get LocalDocuments
  static Future<Map> getLocalDocuments(String database,String docType) async {
    try{
      final LocalDocumentsResponse localDocumentsResponse = await DbUtil.localDocuments.then((value) => value.localDocs(database,key: docType));
      return DbUtil.getResult(localDocumentsResponse.rows);
    }catch(e){
      print(e);
      return await DbUtil.getResult(e,onError: "\nError Get Documents on LocalDocuments");
    }
  }

  //create LocalDocument
  static Future<Map> createLocalDocuments(String database,Map data) async {
    try{
      String id = data['_id'] == '' ? await DbUtil.uuids : data['id'];
      final LocalDocumentsResponse localDocumentsResponse = await DbUtil.localDocuments.then((value) => value.putLocalDoc(database,id,data));
      return DbUtil.getResult(localDocumentsResponse.doc);
    }catch(e){
      print(e);
      return await DbUtil.getResult(e,onError: "\nError Create LocalDocuments");
    }
  }

  //update LocalDocument
  static Future<Map> updateLocalDocuments(String database,Map data) async {
    try{
      final LocalDocumentsResponse localDocumentsResponse = await DbUtil.localDocuments.then((value) => value.putLocalDoc(database,data['_id'],data));
      return DbUtil.getResult(localDocumentsResponse.doc);
    }catch(e){
      print(e);
      return await DbUtil.getResult(e,onError: "\nError Update LocalDocuments");
    }
  }

  //delete LocalDocument
  static Future<Map> deleteLocalDocuments(String database,Map data) async {
    try{
      final LocalDocumentsResponse localDocumentsResponse = await DbUtil.localDocuments.then((value) => value.deleteLocalDoc(database,data['_id'],data['_rev']));
      return DbUtil.getResult(localDocumentsResponse.doc);
    } catch(e){
      print(e);
      return await DbUtil.getResult(e,onError: "\nError Delete LocalDocuments");
    }
  }

}