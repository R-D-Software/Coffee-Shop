import 'dart:ui';

import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/HomeWidgets/item_corner_painter.dart';
import 'package:flutter/material.dart';
class OrderItemComponent extends StatelessWidget 
{
    final String itemID;
    final int orderNo;
    final double itemSize;

    OrderItemComponent(this.itemID, this.orderNo, this.itemSize);

    @override
    Widget build(BuildContext context) 
    {       
        return StreamBuilder
        (
            stream: ShopItemDB.getShopItemByID(itemID),
            builder: (context, snap)
            {
                if(snap.connectionState == ConnectionState.waiting)
                {
                    return Container();
                }
                else
                {
                    return _buildComponent(context, (snap.data as ShopItem));
                }
            },
        );
    }

    Widget _buildComponent(BuildContext context, ShopItem item)
    {
        return Card
        (
            shape: RoundedRectangleBorder
            (
                borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Container
            (
                child: ItemCornerPainter
                (
                    orderNo: this.orderNo,
                    itemSize: itemSize,
                    radius: 16,
                ),
                decoration: BoxDecoration
                (  
                    image: new DecorationImage
                    (
                        fit: BoxFit.cover,
                        image: NetworkImage
                        (
                            item.imageUrl
                        )
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                ),  
            ),
        );
    }
}