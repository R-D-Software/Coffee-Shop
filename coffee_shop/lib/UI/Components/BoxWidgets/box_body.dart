import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/boxes_DB.dart';
import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/post_box.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxBody extends StatefulWidget {
    @override
    _BoxBodyState createState() => _BoxBodyState();
}

class _BoxBodyState extends State<BoxBody> {

  @override
  void initState() {
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                decoration: RenaoBoxDecoration.builder(context),       
                child: StreamBuilder
                (
                    stream: OrderDB.getOrdersForCurrentUser().asStream(),
                    builder: (context, snap)
                    {
                        if(snap.connectionState == ConnectionState.waiting)
                        {
                            return Container();
                        }
                        else
                        {
                            return _buildScreen(context, (snap.data as List<Order>));
                        }
                    },
                ),
            ),
        );
    }

    Widget _buildScreen(BuildContext context, List<Order> orders)
    {
        if(orders == null)
        {
            return _noOrderPage(context);
        }
        if(orders.isEmpty)
        {
            return _noOrderPage(context);
        }
        else
        {
            return _buildBoxPage(context, orders);
        }
    }

    Widget _buildBoxPage(BuildContext context, List<Order> orders)
    {
        Order nearestOrder = Order.getNearestOrder(orders);
        return StreamBuilder
        (
            stream: OrderDB.getOrder(nearestOrder.orderID),
            builder: (context, orderSnap)
            {
                if(orderSnap.connectionState == ConnectionState.waiting)
                {
                    return Container();
                }
                else
                {
                    Order currentOrder = Order.fromDocument(orderSnap.data);

                    return StreamBuilder
                    (
                        stream: BoxesDB.getBoxByID(currentOrder.box),
                        builder: (context, snap)
                        {
                            if(snap.connectionState == ConnectionState.waiting)
                            {
                                return Container();
                            }
                            else
                            {
                                DocumentSnapshot ds = snap.data;
                                if(ds == null)
                                {
                                    return _getNotReadyWidget(context);
                                }
                                else
                                {
                                    return _getOpenerWidget(snap, ds, context, currentOrder);
                                }
                            }
                        },
                    );
                }
            },
        );
    }

    Widget _getNotReadyWidget(BuildContext context)
    {
        return Center
        (
            child: Column
            (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                    StrokedText(text:LanguageModel.youHaveNoBoxYet[LanguageModel.currentLanguage]),
                    _getApproppriateImage(false, context, "-1", "-1", 0.3),                               
                ],
            ),
        );
    }

    Widget _getOpenerWidget(AsyncSnapshot snap, DocumentSnapshot ds, BuildContext context, Order order)
    {
        PostBox box = PostBox.fromDocument(snap.data, ds.documentID);
        String text;
        if(box.open)
        {
            text = LanguageModel.grabYourGoods[LanguageModel.currentLanguage];
        }
        else
        {
           text = LanguageModel.pushThePicture[LanguageModel.currentLanguage]; 
        }
        
        return Center
        (
            child: Column
            (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                    StrokedText(text:text),
                    _getApproppriateImage(box.open, context, box.boxID, order.orderID, 1),                               
                ],
            ),
        );
    }

    Widget _noOrderPage(BuildContext context)
    {
        return Center
        (
            child: Column
            (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                    StrokedText(text:LanguageModel.noCurrentOrders[LanguageModel.currentLanguage],),
                    _getApproppriateImage(false, context, "-1", "-1", 0.30),
                ],
            ),
        );
    }

    Widget _getApproppriateImage(bool open, BuildContext context, String boxID, String orderID, double opacity)
    {
        assert(opacity >= 0 && opacity <= 1);
        double width = MediaQuery.of(context).size.width;
        String picName = "";
        if(open)
        {
            picName = "assets/images/box_open.jpg";
        }
        else
        {
            picName = "assets/images/box_closed.jpg";
        }

        return Card
        (
            shape: RoundedRectangleBorder
            (
                borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 1,
            child: ClipRRect
            (
                borderRadius: BorderRadius.circular(18.0),
                child: GestureDetector
                (
                    onTap: (){if(boxID != "-1") BoxesDB.tryToOpen(boxID, orderID, context);},
                    child: Opacity
                    (
                        opacity: opacity,
                        child: Image.asset
                        ( 
                            picName,
                            width: width * 0.85,
                            height: width * 0.85,
                            fit: BoxFit.contain                           
                        ),
                    )
                ),
            ), 
        );
    }
}