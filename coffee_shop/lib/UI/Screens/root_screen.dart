import 'package:coffee_shop/UI/Screens/home_screen.dart';
import 'package:coffee_shop/UI/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Theme.of(context).primaryColor,
          );
        } else {
          if (snapshot.hasData) {
            return HomeScreen(
              firebaseUser: snapshot.data,
            );
          } else {
            return WelcomeScreen();
          }
        }
      },
    );
  }
}
