import 'dart:ui';

import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';
class CartItemComponent extends StatelessWidget 
{
    final ShopItem item;

    CartItemComponent(this.item);

    @override
    Widget build(BuildContext context) 
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
                child: GestureDetector
                (
                    child: Container
                    (
                        width: 44.0,
                        height: 44.0,
                        margin: EdgeInsets.all(7),
                        child: Align
                        (
                            alignment: Alignment.topRight,
                            child: Image.asset
                            (
                                "assets/images/minussign.png",
                                width:24.0,
                                height:24.0,
                            )
                        )
                    ),
                    onTap: () => {print("touched me")},
                ),
                decoration: BoxDecoration
                (  
                    image: new DecorationImage
                    (
                        fit: BoxFit.cover,
                        image: AssetImage
                        (
                            this.item.imagePath
                        )
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                ),  
            ),
        );
    }
}