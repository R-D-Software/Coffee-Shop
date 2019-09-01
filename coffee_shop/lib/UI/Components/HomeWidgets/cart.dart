import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

import 'cart_item_component.dart';
import 'header_painter.dart';

class Cart extends StatefulWidget 
{

    @override
    _CartState createState() => _CartState();
}

class _CartState extends State<Cart> 
{
    double _maxHeight;
    double _height;
    double _width;
    double _heightBreak;
    double _itemSize;

    @override
    Widget build(BuildContext context) 
    {
        getPropertyValues();

        return Column
        (
            children: 
            [
                HeaderPainter
                (
                	name: "Cart",
                    width: _width,
                    height: _height,
                    maxHeight: _maxHeight,
                    heightBreak: _heightBreak
                ),

                Container
                (
                    margin: EdgeInsets.only(top: 7, bottom: 7),
                    height: this._itemSize,
                    child: ListView
                    (
                        scrollDirection: Axis.horizontal,
                        children: <Widget>
                        [
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: this._itemSize,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: this._itemSize,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: this._itemSize,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: this._itemSize,
                                color: Colors.transparent,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(right: 7),
                                child: CartItemComponent(new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg")),
                                width: this._itemSize,
                                color: Colors.transparent,
                            ),
                        ],
                    )
                )
            ]
        );
    }

    void getPropertyValues() 
    {
        MediaQueryData mQueryData = MediaQuery.of(context);

        this._height = mQueryData.size.height;
        this._width = mQueryData.size.width;
        this._maxHeight = 120;
        this._heightBreak = 57;
        this._itemSize = 100;
    }
}