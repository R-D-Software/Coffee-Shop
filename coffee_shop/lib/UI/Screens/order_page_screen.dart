import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Business/MapNavigator/google_navigator.dart';
import 'package:coffee_shop/Business/string_service.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_toast.dart';
import 'package:coffee_shop/UI/Components/OrderPageWidgets/timepicker_component.dart';
import 'package:coffee_shop/UI/Screens/place_changer_screen.dart';
import 'package:flutter/material.dart';

class OrderPageScreen extends StatefulWidget 
{
    static const String route = '/main/cart/order_page_screen';
    bool buttonAvailable = true;
    Timer t;

    @override
    _OrderPageScreenState createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderPageScreen> 
{
    DateTime orderDate;
    Shop currentShop;
    TimePickerComponent timePicker;
    List<ShopItem> items;
    int totalPrice;
    int minutesAfterOrder;

    @override
    void initState()
    {
        super.initState();
    }

    @override
    void dispose()
    {
        if(widget.t != null)
        {
            widget.t.cancel();
        }
        super.dispose();
    }

    @override
    Widget build(BuildContext context) 
    {
        _initializeData(context);

        return Scaffold
        (
            appBar: AppBar
            (
                actions: <Widget>
                [
                    _buildOrderDateHeader(context, orderDate)
                ],
            ),
            body: StreamBuilder
            (
                stream: UserDB.getCurrentUserSelectedShop().asStream(),
                builder: (context, snapshot)
                {
                    if(snapshot.connectionState == ConnectionState.waiting)
                    {
                        return Container();
                    }
                    else
                    {
                        currentShop = (snapshot.data as Shop);
                        return StreamBuilder
                        (
                            stream: ShopsDB.getCrowdedTimes(currentShop.docID, (orderDate.year.toString() + "." + orderDate.month.toString()), orderDate.day.toString()).asStream(),
                            builder: (context, snap)
                            {
                                if(snap.connectionState == ConnectionState.waiting)
                                {
                                    return Container();
                                }
                                else
                                {
                                    return _buildBody(context, (snap.data as DocumentSnapshot).data);
                                }
                            }
                        );
                    }
                },
            ),
        );
    }

    Widget _buildOrderDateHeader(BuildContext context, DateTime orderDate)
    {
        return Padding
        (
            padding: EdgeInsets.only(right: 8),
            child: Center
            (
                child: Text
                (
                    orderDate.year.toString() + "." + orderDate.month.toString() + "." + orderDate.day.toString() + " " + _getDayFromWeekDay(orderDate.weekday),
                    style: TextStyle
                    (
                        fontSize: 22,
                    ),
                ),
            ),
        );
    }

    Widget _buildBody(BuildContext context, Map<String,dynamic> notSelectableDates)
    {
        return SingleChildScrollView
        (
            scrollDirection: Axis.vertical,
            child: Container
            (
                decoration: RenaoBoxDecoration.builder(context),
                height: MediaQuery.of(context).size.height - new AppBar().preferredSize.height,
                child: Container
                (
                    child: Column
                    (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>
                        [
                            _getPlaceWidget(context),
                            _getTimeWidget(context, notSelectableDates),
                            _getOrderButton(context),
                        ],
                    ),
                ),
                width: double.infinity,
            ),
        );
    }

    void _initializeData(BuildContext context) 
    {
        final Map<String, dynamic> routeArgs = ModalRoute.of(context).settings.arguments;
        orderDate = routeArgs['orderDate'] as DateTime;
        items = routeArgs['items'] as List<ShopItem>;
        totalPrice = routeArgs['totalPrice'] as int;
        minutesAfterOrder = routeArgs['minutesAfterOrder'] as int;
    }

    @override
    void didUpdateWidget(OrderPageScreen oldWidget) {
        super.didUpdateWidget(oldWidget);
        setState(() {});
    }

    String _getDayFromWeekDay(int day)
    {
        return LanguageModel.dayName(day-1);       
    }

    Widget _getTimeWidget(BuildContext context, Map<String,dynamic> notSelectableDates)
    {
        timePicker = TimePickerComponent
        (
            notSelectableDates: notSelectableDates, 
            currentShop: currentShop,

            date: orderDate, 
            minutesAfterOrder: minutesAfterOrder
        );
        
        return Padding
        (
            padding: EdgeInsets.all(10),
            child: timePicker,
        );
    }

    Widget _getPlaceWidget(BuildContext context)
    {
        return GestureDetector
        (
            onTap: () async 
            {
                await Navigator.of(context).pushNamed(PlaceChangerScreen.route);              
                setState((){});
            },
            child: Container
            (
                height: MediaQuery.of(context).size.width * 0.80,
                child: Card
                (
                    shape: RoundedRectangleBorder
                    (
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    child: Stack
                    (
                        children: <Widget>
                        [
                            ClipRRect
                            (
                                borderRadius: new BorderRadius.circular(40.0),
                                child: Image.network
                                (
                                    currentShop.imageURL,
                                    height: MediaQuery.of(context).size.width * 0.80,
                                    width: MediaQuery.of(context).size.width * 0.80,
                                ),
                            ),
                            
                            _buildPlaceHeader(context),
                        ],
                    ),  
                ),
            ),
        );
    }

    Widget _buildPlaceHeader(BuildContext context)
    {
        return GestureDetector
        (
            onTap: ()
            {
                GoogleNavigator.navigate(currentShop.latitude, currentShop.longitude);
            },
            child: Container
            (
                decoration: BoxDecoration
                (
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    color: Colors.grey.withOpacity(0.8),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.80,
                alignment: Alignment.center,
                child: SizedBox
                (
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Row
                    (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>
                        [
                            Expanded
                            ( 
                                child: AutoSizeText
                                (
                                    currentShop.toString().toUpperCase(),
                                    style: TextStyle
                                    (
                                        color: Colors.white
                                    ),
                                    maxFontSize: 20,
                                    minFontSize: 10,
                                    maxLines: 1,
                                ),
                            ),
                            
                            Icon(Icons.navigation,color: Colors.blue,),
                        ],
                    ),
                )
            ),
        );
    }

    Widget _getOrderButton(BuildContext context)
    {
        return Padding
        (
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: ButtonTheme(
                    buttonColor: Color.fromRGBO(231, 82, 100, 1),
                    minWidth: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    elevation: 0,
                    onPressed:()
                    {
                        if(widget.buttonAvailable)
                        {
                            widget.buttonAvailable = false;
                            widget.t = Timer(Duration(seconds: 30), (){setState(() {
                                widget.buttonAvailable = true;
                            });});                                                             
                            timePicker.stopClock();
                        _order(context);
                        }                       
                    },
                    child: Text(
                        LanguageModel.order[LanguageModel.currentLanguage],
                        style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    ),
                ),
            ),
        );
    }

    void _order(BuildContext context) async
    {
        bool result = await OrderDB.placeOrder
        (
            context,
            timePicker: timePicker,
            currentUser: StaticData.currentUser,
            currentShop: currentShop,
            yearMonth: orderDate.year.toString() + "." + StringService.toDateFormatNumber(orderDate.month),
            day: StringService.toDateFormatNumber(orderDate.day),
            cartItems: items
        );

        Navigator.of(context).pop();

        if(result)
        {
            RenaoToast.orderSuccessful();
        }
        else
        {
            RenaoToast.orderDeclined();
        }
    }
}
