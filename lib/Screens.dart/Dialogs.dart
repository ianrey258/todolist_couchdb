import 'package:flutter/material.dart';
import 'package:todolist_couchDb/Controller/Controller.dart';
import 'package:todolist_couchDb/Database/couchDb.dart';

class AddListDialog extends StatefulWidget {
  @override
  _AddListDialogState createState() => _AddListDialogState();
}

class _AddListDialogState extends State<AddListDialog> {
  ScrollController sc = ScrollController();
  List<TextEditingController> text = [];

  @override
  initState(){
    super.initState();
    for(int i=0;i<3;i++)text.add(TextEditingController());
  }

  Widget textField(index,inputType,title) => Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(10),
    child: TextFormField(
      controller: text[index],
      keyboardType: inputType,
      decoration: InputDecoration(labelText: title),
    ),
  );

  Widget formTodo(){
    return ListView(
      children: [
        textField(0, TextInputType.name, 'Title Event'),
        textField(1, TextInputType.multiline, 'Activity'),
        textField(2, TextInputType.datetime, 'Datatime'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*.6,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(child: Text('- Add List -',style: TextStyle(fontSize: 20),),),
            Expanded(child: Center(child: formTodo(),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(onPressed: (){Navigator.pop(context);},child: Text("Cancel"),color: Colors.red,),
                SizedBox(width: 10,),
                RaisedButton(onPressed: ()async{await TodoController.createTodos();Navigator.pop(context);},child: Text("Add"),color: Colors.blue,),
                SizedBox(width: 10,),
              ],
            )
          ],
        ),
      )
    );
  }
}

class EditListDialog extends StatefulWidget {
  @override
  _EditListDialogState createState() => _EditListDialogState();
}

class _EditListDialogState extends State<EditListDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class DeleteDialog extends StatefulWidget {
  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Are You Sure ?'),),
      content: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(onPressed: (){Navigator.pop(context);},child: Text("Cancel"),color: Colors.red,),
            SizedBox(width: 10,),
            RaisedButton(onPressed: ()async{await TodoController.deleteTodos();Navigator.pop(context);},child: Text("Delete"),color: Colors.blue,),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}

class ResultDialog extends StatefulWidget {
  final String msg;
  ResultDialog({Key key,this.msg}):super(key: key);
  @override
  _ResultDialogState createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.msg),
    );
  }
}