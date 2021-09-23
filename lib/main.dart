

import 'package:chatify/pages/login_page.dart';
import 'package:chatify/pages/registeration_page.dart';
import 'package:chatify/services/navigation_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Chatify",
      navigatorKey: NavigationService.instance.navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42,117, 188, 1),
        accentColor: Color.fromRGBO(42,117, 188, 1),
        backgroundColor: Color.fromRGBO(28,27, 27, 1),
      ),
      initialRoute: 'login',
      routes: {
        'login': (_) => LogIn(),
        'register': (_) => RegisterationPage(),
      },
    );
  }
}
