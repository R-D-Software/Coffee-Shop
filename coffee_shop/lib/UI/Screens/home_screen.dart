import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/UI/Components/BottomNavigationBarComponent.dart';
import 'package:coffee_shop/UI/Components/Home/cart.dart';
import 'package:coffee_shop/UI/Components/Home/item_slider.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  HomeScreen({this.firebaseUser});

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.firebaseUser);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar(
          iconTheme: new IconThemeData(color: Theme.of(context).accentColor),
          backgroundColorStart: Colors.brown,
          backgroundColorEnd: Theme.of(context).accentColor,
          bottom: PreferredSize(
              child: Container(
                color: Colors.orange,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 14),
                child: StrokedText(text: "Home", size: 40),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Renao'),
              ),
              ListTile(
                title: Text('Log Out'),
                onTap: () {
                  _logOut();
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Cart(),
            ItemSlider("Coffee"),
            ItemSlider("Breakfast"),
            ItemSlider("Today's Deals"),
            ItemSlider("Coffee Again"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarComponenet(),
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

  void _logOut() async {
    Auth.signOut();
  }
}
