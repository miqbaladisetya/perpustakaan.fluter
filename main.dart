import 'package:flutter/material.dart';
import 'package:flutteruas/userdata.dart';
import 'package:flutteruas/useritem.dart';
import 'package:flutteruas/userlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}