import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterauth0/auth0_utils.dart';
import 'package:flutterauth0/login.dart';
import 'package:uni_links/uni_links.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
