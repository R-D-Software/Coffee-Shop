import 'package:coffee_shop/UI/Components/CartWidgets/cart_body.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_scaffold.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RenaoScaffold(
        appBarTitle: "Cart",
        scaffoldBody: CartBody(),
      ),
      decoration: RenaoBoxDecoration.builder(context),
    );
  }
}
