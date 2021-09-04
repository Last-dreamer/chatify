

import 'package:chatify/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chatify",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42,117, 188, 1),
        accentColor: Color.fromRGBO(42,117, 188, 1),
        backgroundColor: Color.fromRGBO(28,27, 27, 1),
      ),
      home: LogIn(),
    );
  }
}
