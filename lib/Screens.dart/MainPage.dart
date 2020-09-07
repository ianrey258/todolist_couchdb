import 'package:flutter/material.dart';
import 'package:todolist_couchDb/Controller/Controller.dart';
import 'package:todolist_couchDb/Database/couchDb.dart';
import 'package:todolist_couchDb/Screens.dart/Dialogs.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController sc = ScrollController();
  bool refresh = false;

  void refreshState(){
    setState(() {
      refresh = refresh ? false : true;
    });
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    refreshState();
    return null;
  }

  Future<Null> addList(){
    return showDialog(
      context: context,
      builder: (_)=>AddListDialog()
    );
  }

  Future<Null> editList(){
    return showDialog(
      context: context,
      builder: (_)=>EditListDialog()
    );
  }

  Future<Null> removeList(){
    return showDialog(
      context: context,
      builder: (_)=>DeleteDialog()
    );
  }

  Widget todoContainer(){
    return Card(
      child: ListTile(
        onTap: (){},
        title: Text('Title Event'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity'),
            Text('Datetime')
          ],
        ),
        trailing: Container(
          width: 80,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 40,
                child: FlatButton(padding: EdgeInsets.all(0), child: Icon(Icons.edit,size: 20,), onPressed: ()async{
                  //await DbNetAccess.updateDocument({});
                },),
              ),
              Container(
                alignment: Alignment.center,
                width: 40,
                child: FlatButton(padding: EdgeInsets.all(0), child: Icon(Icons.delete,size: 20,), onPressed: removeList,),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget todosStream(){
    return RefreshIndicator(
      onRefresh: refreshList,
      child: StreamBuilder(
        stream: TodoController.getTodos().asStream(),
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            print(snapshot.data);
            return Container(
              child: ListView.builder(
                controller: sc,
                itemCount: 5,
                itemBuilder: (_,i)=>todoContainer()
              ),
            );
          }
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10,),
                Text("Loading Data ..")
              ],
            )
          );
        }
      ),
    );
  }

  Widget todos(){
    return RefreshIndicator(
      onRefresh: refreshList,
      child: FutureBuilder(
        future: TodoController.getTodos(),
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            return Container(
              child: ListView.builder(
                controller: sc,
                itemCount: 5,
                itemBuilder: (_,i)=>todoContainer()
              ),
            );
          }
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10,),
                Text("Loading Data ..")
              ],
            )
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List with couchDb'),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: refreshState)],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: todosStream(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: addList,child: Icon(Icons.add),),
    );
  }
}