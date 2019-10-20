import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/MapNavigator/google_navigator.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

import 'cart_item_component.dart';
import 'header_painter.dart';

class CurrentOrderOnHomeScreenWidget extends StatefulWidget {
  @override
  _CurrentOrderOnHomeScreenWidgetState createState() => _CurrentOrderOnHomeScreenWidgetState();
}

class _CurrentOrderOnHomeScreenWidgetState extends State<CurrentOrderOnHomeScreenWidget> {
  double _maxHeight;
  double _height;
  double _width;
  double _heightBreak;
  double _itemSize;

    @override
    Widget build(BuildContext context) {
        _getPropertyValues();

        return StreamBuilder
        (
            stream: OrderDB.getOrdersForCurrentUser().asStream(),
            builder: (context, snapshot)
            {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                    return Container();
                }
                else
                {
                    List<Order> orders = (snapshot.data as List<Order>);

                    if(orders.isEmpty)
                    {
                        return Container();
                    }

                    return _buildBody(context, orders);
                }
            },
        );   
    }

    Widget _buildBody(BuildContext context, List<Order> orders)
    {
        return Column
        (
            children: 
            [
                HeaderPainter
                (
                    name: LanguageModel.orders[LanguageModel.currentLanguage],
                    width: _width,
                    height: _height,
                    maxHeight: _maxHeight,
                    heightBreak: _heightBreak,
                    icon: Icons.navigation,
                    onIconClick: ()
                    {
                        _navigatoToShop(_getNearestOrder(orders));
                    },
                ),
                Container
                (
                    margin: EdgeInsets.only(top: 7, bottom: 7),
                    height: this._itemSize,
                    child: ListView
                    (
                        scrollDirection: Axis.horizontal,
                        children: _getItems(orders),
                    )
                )
            ]
        );
    }

  void _getPropertyValues() {
    MediaQueryData mQueryData = MediaQuery.of(context);

    this._height = mQueryData.size.height;
    this._width = mQueryData.size.width;
    this._maxHeight = 120;
    this._heightBreak = 57;
    this._itemSize = 100;
  }

    List<Widget> _getItems(List<Order> orders)
    {
        List<Widget> retList = new List<Widget>();

        for(Order order in orders)
        {
            for(String itemID in order.items)
            {
                retList.add
                (
                    Container
                    (
                        margin: EdgeInsets.only(right: 7),
                        child: CartItemComponent(itemID, orders.indexOf(order), _itemSize),
                        width: this._itemSize,
                        color: Colors.transparent,
                    )
                );
            }
        }
        
        return retList;
    }

    List<Widget> _getEmptyField() {
        return <Widget>[
        Container(
            width: _width,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Card(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset("assets/images/kav.jpg")),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    )),
                StrokedText(
                text: LanguageModel.noOrder[LanguageModel.currentLanguage],
                color: Colors.white,
                size: 25,
                )
            ],
            ),
        )
        ];
    }

    Order _getNearestOrder(List<Order> orders)
    {
        Order retOrder = orders.first;

        for(Order order in orders)
        {
            if(_stringToDate(retOrder).compareTo(_stringToDate(order)) > 0)
            {
                retOrder = order;
            }
        }
        return retOrder;
    }

    DateTime _stringToDate(Order order)
    {
        String formattedString = order.date.toString() + "T" + order.time.toString() + "00";
        formattedString = formattedString.replaceAll(RegExp("\\."), "");
        formattedString = formattedString.replaceAll(RegExp(":"), "");
        return DateTime.parse(formattedString);
    }

    void _navigatoToShop(Order order) async
    {
        Shop shop = await ShopsDB.getShopByID(order.shopID);

        GoogleNavigator.navigate(shop.latitude, shop.longitude);
    }
}
