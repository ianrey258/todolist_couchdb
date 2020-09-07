import 'package:flutter/material.dart';
import 'package:todolist_couchDb/Database/couchDb.dart';
import 'package:todolist_couchDb/Screens.dart/LoginPage.dart';
import 'package:todolist_couchDb/Screens.dart/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList Sample with CouchDb',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/' : (BuildContext context) => LoginPage(),
        '/main' : (BuildContext context) => MainPage()
      },
    );
  }
}
