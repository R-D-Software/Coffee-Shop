import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_scaffold.dart';
import 'package:coffee_shop/UI/Components/HomeWidgets/home_body.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState()
    {
        super.initState();
    }

  @override
  Widget build(BuildContext context) {    
    return Container
    (
        child: RenaoScaffold(
            appBarTitle: LanguageModel.home[LanguageModel.currentLanguage],
            scaffoldBody: HomeScreenBody(),
        ),
        decoration: RenaoBoxDecoration.builder(context),
    );     
  }
}
