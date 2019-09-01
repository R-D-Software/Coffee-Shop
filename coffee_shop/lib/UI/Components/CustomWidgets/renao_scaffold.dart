import 'package:coffee_shop/UI/Components/CustomWidgets/renao_appbar.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_drawer.dart';
import 'package:flutter/material.dart';

class RenaoScaffold extends StatefulWidget {
  final String appBarTitle;
  final Widget scaffoldBody;

  RenaoScaffold({@required this.appBarTitle, @required this.scaffoldBody});

  @override
  _RenaoScaffoldState createState() => _RenaoScaffoldState();
}

class _RenaoScaffoldState extends State<RenaoScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: RenaoAppBar(
        title: widget.appBarTitle,
      ),
      drawer: RenaoDrawer(),
      body: widget.scaffoldBody,
    );
  }
}