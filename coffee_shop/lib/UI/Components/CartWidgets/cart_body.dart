import 'package:coffee_shop/Models/CartItem.dart';
import 'package:coffee_shop/Models/dummy_data.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

import 'cart_list_item.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();

  double bottomBarHeight = 50;
  double bottomNavBarHeight = 112;
  int sum = 0;
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    List<CoffeeItem> cartItems = DummyData.cartItems;

    return Scaffold(
      body: Container(
        decoration: RenaoBoxDecoration.builder(context),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height -
                  widget.bottomNavBarHeight -
                  widget.bottomBarHeight,
              child: cartItems.isNotEmpty
                  ? _getCoffeeList(cartItems)
                  : _getEmptyList(),
            ),
            Container(
              height: widget.bottomBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  StrokedText(
                    text: "Végösszeg: ${widget.sum}",
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  RenaoFlatButton(
                    title: "Időpont",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      print('pay');},
                    borderColor: Colors.black12,
                    borderWidth: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCoffeeList(List<CoffeeItem> items) {
    return ListView(
      children: items.map((f) {
        widget.sum += f.price * f.itemCount;
        return Container(
          margin: f == items.first
              ? EdgeInsets.only(top: 30)
              : EdgeInsets.only(top: 0),
          child: CartListItem(item: f),
        );
      }).toList(),
    );
  }

  Widget _getEmptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[],
    );
  }
}
