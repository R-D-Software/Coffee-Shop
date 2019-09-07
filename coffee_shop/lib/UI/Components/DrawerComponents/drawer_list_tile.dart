import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function action;
  DrawerListTile({@required this.iconData, @required this.text, @required this.action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(iconData, color: Theme.of(context).accentColor,),
        title: Text(text, style: TextStyle(color: Theme.of(context).accentColor),),
        onTap: () {
          Navigator.pop(context);
          action();
        });
  }
}
