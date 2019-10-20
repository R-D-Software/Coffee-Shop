import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Cart/decide_item_type.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/order_date_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
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
    final int startTime = 6;
    final int endTime = 17;
    final int minutesAfterOrder = 30;
}

class _CartBodyState extends State<CartBody> {

    List<DateTime> holidays;

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
          margin: f == items.first
              ? EdgeInsets.only(top: 30)
              : EdgeInsets.only(top: 0),
          child: CartListItem(item: f, refreshFunction: refreshFunction),
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
          List<ShopItem> cartItems = new List<ShopItem>();

          for (DocumentSnapshot doc in shopItems.documents) {
            ShopItem item = DecideItemType.getItemByClassFromFireStore(doc);
            cartItems.add(item);
          }

          if (shopItems == null) return Container();

          if(cartItems.isEmpty)
          {
              return _buildEmptyCart(context);
          }
          else
          {
              return _buildCartWithItems(context, cartItems);
          }
        });
  }

    Widget _buildEmptyCart(BuildContext context)
    {
        return Center
        (
            child: Text("lofaszvagy"),
        );
    }

    Widget _buildCartWithItems(BuildContext context, List<ShopItem> cartItems)
    {
        return Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height -
                    widget.bottomNavBarHeight -
                    widget.bottomBarHeight,
                child: _getCartItems(cartItems),
              ),
              _getBottomBar(context, cartItems),
            ],
          );
    }

    Widget _getBottomBar(BuildContext context, List<ShopItem> cartItems)
    {
        if(cartItems.isEmpty)
        {
            return Container();
        }

        return Container
        (
            height: widget.bottomBarHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>
                [
                    StrokedText(
                        text: LanguageModel.total(getTotal(cartItems)),
                        size: 20,
                        color: Theme.of(context).primaryColor,
                    ),
                    RenaoFlatButton
                    (
                        title: LanguageModel.time[LanguageModel.currentLanguage],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,    
                        textColor: Theme.of(context).primaryColor,
                        onPressed: ()
                        {
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

    void refreshFunction()
    {
        setState(() {});
    }


    bool selectableDate(DateTime selected)
    {
        DateTime now = DateTime.now();

        if(now.year == selected.year
            && now.month == selected.month
            && now.day == selected.day)
        {
            if(((widget.endTime-1) == now.hour && (60 - now.minute) < widget.minutesAfterOrder)
                || now.hour >= widget.endTime)
            {
                return false;
            }
        }

        for(DateTime date in holidays)
        {
            if(selected.year == date.year
                && selected.month == date.month
                && selected.day == date.day)
                return false;
        }
        return selected.weekday < 6;
    }

    DateTime getInitialDate(DateTime selected)
    {
        if(selectableDate(selected))
        {
            return selected;
        }
        else
        {
            return getInitialDate(selected.add(new Duration(days:1)));
        }
    }

    void pickDate(List<ShopItem> cartItems) async 
    {
        holidays = await OrderDateDB.getHolidays();
        DateTime today = DateTime.now();
        DateTime initialDate = getInitialDate(DateTime.now());
        DateTime nextMonth = today.add(new Duration(days: 30));
        DateTime orderDate = await showDatePicker(
            context: context,
            firstDate: today,
            initialDate: initialDate,
            lastDate: nextMonth,
            selectableDayPredicate: selectableDate);

        if (orderDate != null)
        {
            Navigator.of(context).pushNamed(OrderPageScreen.route, arguments: 
            {
                "orderDate": orderDate,
                "items": cartItems,
                "totalPrice": getTotal(cartItems),
                "startTime": widget.startTime,
                "endTime": widget.endTime,
                "minutesAfterOrder": widget.minutesAfterOrder
            });
        }  
    }
}
