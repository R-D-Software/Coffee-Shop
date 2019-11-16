import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/MapNavigator/google_navigator.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/HomeWidgets/timeleft_widget.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:coffee_shop/UI/Screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import 'order_item_component.dart';
import 'header_painter.dart';

class CurrentOrderOnHomeScreenWidget extends StatefulWidget {
    final List<Order> orders;
    
    CurrentOrderOnHomeScreenWidget(this.orders);

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

        if(widget.orders == null)
            return Container();
        if(widget.orders.isNotEmpty)
            return _buildBody(context, widget.orders);  
        else
            return Container();
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
                        _navigatoToShop(Order.getNearestOrder(orders));
                    },
                ),
                Container
                (
                    margin: EdgeInsets.only(top: 7, bottom: 7),
                    height: this._itemSize,
                    child: ListView
                    (
                        scrollDirection: Axis.horizontal,
                        children: _getItems(orders, context),
                    )
                ),
                Center
                (
                    child: TimeLeftWidget(Order.getNearestOrder(orders))
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

    List<Widget> _getItems(List<Order> orders, BuildContext context)
    {
        List<Widget> retList = new List<Widget>();

        for(Order order in orders)
        {
            for(String itemID in order.items)
            {
                retList.add
                (
                    GestureDetector
                    (
                        onTap: (){Navigator.of(context).pushNamed(OrderDetailsScreen.route, arguments: {"order": order});},
                        child: Container
                        (
                            margin: EdgeInsets.only(right: 7),
                            child: OrderItemComponent(itemID, orders.indexOf(order), _itemSize),
                            width: this._itemSize,
                            color: Colors.transparent,
                        )
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

    void _navigatoToShop(Order order) async
    {
        Shop shop = await ShopsDB.getShopByID(order.shopID);

        GoogleNavigator.navigate(shop.latitude, shop.longitude);
    }
}