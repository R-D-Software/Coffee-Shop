import 'package:coffee_shop/Business/auth.dart';
import 'package:flutter/material.dart';

class RenaoDrawer extends StatefulWidget {
  @override
  _RenaoDrawerState createState() => _RenaoDrawerState();
}

class _RenaoDrawerState extends State<RenaoDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }

  void _logOut() async {
    Auth.signOut();
  }
}