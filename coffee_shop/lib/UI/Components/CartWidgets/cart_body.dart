import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Cart/decide_item_type.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_waiting_ring.dart';
import 'package:flutter/material.dart';

import '../stroked_text.dart';
import 'cart_list_item.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();

  double bottomBarHeight = 50;
  double bottomNavBarHeight = 112;
}

class _CartBodyState extends State<CartBody> {
  @override
  void initState() {
    super.initState();
//    getCoffees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: RenaoBoxDecoration.builder(context),
        child: _buildScreen(),
      ),
    );
  }

  Widget _getCartItems(List<ShopItem> items) {
    return ListView(
      children: items.map((f) {
        return Container(
          margin: f == items.first ? EdgeInsets.only(top: 30) : EdgeInsets.only(top: 0),
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

  Widget _buildScreen() {
    return StreamBuilder(
        stream: CartItemDB.fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return RenaoWaitingRing();

          QuerySnapshot shopItems = snapshot.data as QuerySnapshot;
          List<ShopItem> cartItems = [];

          for (DocumentSnapshot doc in shopItems.documents) {
            ShopItem item = DecideItemType.getItemByClassFromFireStore(doc);
            cartItems.add(item);
          }

          if (shopItems == null) return Container();

          return Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - widget.bottomNavBarHeight - widget.bottomBarHeight,
                child: cartItems.isNotEmpty ? _getCartItems(cartItems) : _getEmptyList(),
              ),
              Container(
                height: widget.bottomBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    StrokedText(
                      text: "Végösszeg: ${getTotal(cartItems)}",
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    RenaoFlatButton(
                      title: "Időpont",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        print("időpont");
                      },
                      borderColor: Colors.black12,
                      borderWidth: 2,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  int getTotal(List<ShopItem> cartItems) {
    int total = 0;
    for (ShopItem item in cartItems) {
      total += item.price;
    }
    return total;
  }
}
