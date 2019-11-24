import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Cart/decide_item_type.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/order_date_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_empty_list.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_waiting_ring.dart';
import 'package:coffee_shop/UI/Screens/order_page_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../stroked_text.dart';
import 'cart_list_item.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();

  double bottomBarHeight = 50;
  double bottomNavBarHeight = 112;
  int startTime;
  int endTime;
  final int minutesAfterOrder = 30;
  List<ShopItem> cartItems;
}

class _CartBodyState extends State<CartBody> {
  List<DateTime> holidays;
  Shop selectedShop;
  DateTime today = DateTime.now(); //DateTime.parse("2019-10-25 18:19:00"); //FOR DEBUGGING;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: RenaoBoxDecoration.builder(context),
        child: StreamBuilder(
          stream: ShopsDB.getShopByID(StaticData.currentUser.selectedShop).asStream(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              widget.startTime = (snap.data as Shop).opensHour;
              widget.endTime = (snap.data as Shop).closesHour;
              selectedShop = (snap.data as Shop);
              return _buildScreen();
            }
          },
        ),
      ),
    );
  }

  Widget _getCartItems(List<ShopItem> items) {
    return ListView(
      children: items.map((f) {
        return Container(
          margin: f == items.first ? EdgeInsets.only(top: 30) : EdgeInsets.only(top: 0),
          child: CartListItem(item: f, refreshFunction: refreshFunction),
        );
      }).toList(),
    );
  }


  Widget _buildScreen() {
    return StreamBuilder(
        stream: CartItemDB.fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return RenaoWaitingRing();

          QuerySnapshot shopItems = snapshot.data as QuerySnapshot;
          widget.cartItems = new List<ShopItem>();

          for (DocumentSnapshot doc in shopItems.documents) {
            ShopItem item = DecideItemType.getItemByClassFromFireStore(doc);
            widget.cartItems.add(item);
          }

          if (shopItems == null) return Container();

          if (widget.cartItems.isEmpty) {
            return RenaoEmptyList(
              imagePath: "assets/images/kav.jpg",
              textHeader: LanguageModel.yourCartIsEmpty[LanguageModel.currentLanguage],
              textDescription: LanguageModel.addToCartDescription[LanguageModel.currentLanguage],
            );
          } else {
            return _buildCartWithItems(context, widget.cartItems);
          }
        });
  }

    Widget _buildCartWithItems(BuildContext context, List<ShopItem> cartItems)
    {
        return Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height
                    - widget.bottomNavBarHeight
                    - widget.bottomBarHeight
                    - 29,
                child: _getCartItems(cartItems),
              ),
              _getBottomBar(context, cartItems),
            ],
          );
    }

  Widget _getBottomBar(BuildContext context, List<ShopItem> cartItems) {
    if (cartItems.isEmpty) {
      return Container();
    }

    return Container(
      height: widget.bottomBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StrokedText(
            text: LanguageModel.total(getTotal(cartItems)),
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          RenaoFlatButton(
            title: LanguageModel.time[LanguageModel.currentLanguage],
            fontSize: 16,
            fontWeight: FontWeight.w700,
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              pickDate(cartItems);
            },
            borderColor: Colors.black12,
            borderWidth: 2,
          )
        ],
      ),
    );
  }

  int getTotal(List<ShopItem> cartItems) {
    int total = 0;
    for (ShopItem item in cartItems) {
      total += item.price;
    }
    return total;
  }

  void refreshFunction() {
    setState(() {});
  }

  ///TODO: Magic number eltüntetése
  bool selectableDate(DateTime selected) {
    if (today.difference(selected).inMinutes.abs() < 30) return false;

    for (DateTime date in holidays) {
      if (selected.year == date.year && selected.month == date.month && selected.day == date.day) return false;
    }
    return selected.weekday < 6;
  }

  DateTime getInitialDate(DateTime selected) {
    if (selectableDate(selected) && selected.isAfter(today)) {
      return DateTime(selected.year, selected.month, selected.day);
    } else {
      return getInitialDate(selected.add(new Duration(days: 1)));
    }
  }

  void pickDate(List<ShopItem> cartItems) async {
    holidays = await OrderDateDB.getHolidays();
    DateTime initialDate = getInitialDate(
        DateTime(today.year, today.month, today.day, selectedShop.closesHour, selectedShop.closesMinute));
    DateTime nextMonth = today.add(new Duration(days: 30));
    DateTime orderDate = await showDatePicker(
        context: context,
        firstDate: DateTime(initialDate.year, initialDate.month, initialDate.day),
        initialDate: initialDate,
        lastDate: nextMonth,
        selectableDayPredicate: (selected) {
          selected =
              DateTime(selected.year, selected.month, selected.day, selectedShop.closesHour, selectedShop.closesMinute);
          return selectableDate(selected);
        });

    if (orderDate != null) {
      Navigator.of(context).pushNamed(OrderPageScreen.route, arguments: {
        "orderDate": orderDate,
        "items": cartItems,
        "totalPrice": getTotal(cartItems),
        "minutesAfterOrder": widget.minutesAfterOrder
      });
    }
  }
}
