import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CartWidgets/cart_body.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_scaffold.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RenaoScaffold(
          appBarTitle: LanguageModel.cart[LanguageModel.currentLanguage],
          scaffoldBody: CartBody(),
        ),
        decoration: RenaoBoxDecoration.builder(context),
      ),
    );
  }
}
