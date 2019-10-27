import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/WalletWidgets/wallet_body.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  static const String route = '/main/wallet';
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> 
{
    final AppBar appBar = AppBar
    (
        centerTitle: true,
        title: Text(LanguageModel.wallet[LanguageModel.currentLanguage]),
    );

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold
        (
            appBar: this.appBar,
            body: Container
            (
                child: WalletBody(appBarHeight: this.appBar.preferredSize.height),
                decoration: RenaoBoxDecoration.builder(context)
            ),
        );
    }
}