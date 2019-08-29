import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/UI/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UI/Screens/log_in_screen.dart';
import 'UI/Screens/root_screen.dart';
import 'UI/Screens/sign_up_screen.dart';

void main() {
  Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renao',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/root': (BuildContext context) => RootScreen(),
        '/signin': (BuildContext context) => LogInScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
        '/main': (BuildContext context) => HomeScreen(),
      },
      theme: ThemeData(
          primaryColor: Color.fromRGBO(76, 53, 47, 1),
          accentColor: Color.fromRGBO(171, 122, 91, 1),
          textTheme: TextTheme(body1: TextStyle(fontFamily: "Roboto", fontSize: 20)),
          iconTheme: IconThemeData(color: Colors.white, opacity: 1, size: 39)),
      home: RootScreen(),
    );
  }
}
