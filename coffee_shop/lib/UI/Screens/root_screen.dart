import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/Navigation/main_screen.dart';
import 'package:coffee_shop/UI/Screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  static const String route = '/root';

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
            return StreamBuilder
            (
                stream: LanguageModel.init(context).asStream(),
                builder: (context, snap)
                {
                    if(snap.connectionState == ConnectionState.waiting)
                    {
                        return new Container(
                            color: Theme.of(context).primaryColor,
                        );
                    }
                    else
                    {
                        if (snapshot.hasData) {
                            UserDB.updateToken();
                            return MainScreen();
                        } else {
                            return WelcomeScreen();
                        }
                    }
                },
            ); 
        }
      },
    );
  }
}
