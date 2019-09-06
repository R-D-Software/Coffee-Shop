import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class RenaoAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;

  RenaoAppBar({@required this.title});

  @override
  _RenaoAppBarState createState() => _RenaoAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _RenaoAppBarState extends State<RenaoAppBar> {
  @override
  Widget build(BuildContext context) {
    return GradientAppBar(
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
            child: StrokedText(text: widget.title, size: 40, fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}
