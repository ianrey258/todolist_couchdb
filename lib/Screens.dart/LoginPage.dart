import 'package:flutter/material.dart';
import 'package:todolist_couchDb/Controller/Controller.dart';
import 'package:todolist_couchDb/DataModel/User.dart';
import 'package:todolist_couchDb/Database/couchDb.dart';
import 'package:todolist_couchDb/Screens.dart/Dialogs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ScrollController sc = ScrollController();
  List<TextEditingController> text = [];
  final _key = GlobalKey<FormState>();
  

  @override
  void initState(){
    super.initState();
    for(int i=0;i<2;i++)text.add(TextEditingController());
  }

  Future<Null> showResult(msg){
    return showDialog(
      context: context,
      builder: (_)=>ResultDialog(msg: msg,)
    );
  }


  Future<void> loginValidate() async {
    if(_key.currentState.validate()){
      _key.currentState.save();
      User user = User(username: text[0].text,password: text[1].text,docType: DbUtil.DOCTYPE['user_auth']);
      var result = await Controller.login(user);
      result.isNotEmpty ? result['onError'] == 'None' && result['result'].isNotEmpty ? Navigator.popAndPushNamed(context, '/main') : showResult('Wrong Username or Password') : showResult('Check Internet Connection');
    }
  }

  Future<void> registerValidate() async {
    if(_key.currentState.validate()){
      _key.currentState.save();
      User user = User(username: text[0].text,password: text[1].text,docType: DbUtil.DOCTYPE['user_auth']);
      var result = await UserController.createUser(user);
      result['onError'] == 'None'? showResult('Account Registered') : showResult('Sorry cant Register') ;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.yellow,
                width: MediaQuery.of(context).size.width*.30,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Todo',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('List',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: text[0],
                        decoration: InputDecoration(
                          hintText: "Username"
                        ),
                        validator: (value) => value.length != 0 ? null : 'Invalid Username',
                      ),
                      TextFormField(
                        controller: text[1],
                        decoration: InputDecoration(
                          hintText: "Password"
                        ),
                        obscureText: true,
                        validator: (value) => value.length != 0 ? null : 'Invalid Password',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: RaisedButton(onPressed: registerValidate,child: Text("Register"),color: Colors.red,)),
                          SizedBox(width: 10,),
                          Expanded(child: RaisedButton(onPressed: loginValidate,child: Text("Login"),color: Colors.blue,)),
                          SizedBox(width: 10,),
                        ],
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}