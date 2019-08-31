import 'package:coffee_shop/UI/Components/CustomWidgets/renao_scaffold.dart';
import 'package:coffee_shop/UI/Components/Home/home_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  HomeScreen({this.firebaseUser});

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.firebaseUser);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RenaoScaffold(
        appBarTitle: "Home",
        scaffoldBody: HomeScreenBody(),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.6, 0.9],
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).accentColor.withOpacity(0.8),
          ],
        ),
      ),
    );
  }
}
