import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_scaffold.dart';
import 'package:coffee_shop/UI/Components/QuestWidgets/quest_body.dart';
import 'package:flutter/material.dart';

class QuestScreen extends StatefulWidget {
  @override
  _QuestScreenState createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RenaoScaffold(
        appBarTitle: LanguageModel.quest[LanguageModel.currentLanguage],
        scaffoldBody: QuestBody(),
      ),
      color: Theme.of(context).accentColor,
    );
  }
}
