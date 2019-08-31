import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/Home/header_painter.dart';
import 'package:flutter/material.dart';

import 'item_component.dart';

class ItemSlider extends StatefulWidget 
{
    final String name;

    ItemSlider(this.name);

    @override
    _ItemSliderState createState() => _ItemSliderState();
}

class _ItemSliderState extends State<ItemSlider> 
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
                            name: widget.name,
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
                                        child: ItemComponent(new ShopItem(name: "Cat Poop Coffee", price: 250, imagePath: "assets/images/kav.jpg"), height: this._itemSize, width: this._itemSize),
                                        width: this._itemSize,
                                        color: Colors.transparent,
                                    ),
                                    Container
                                    (
                                        margin: EdgeInsets.only(right: 7),
                                        child: ItemComponent(new ShopItem(name: "Cappuccino", price: 300, imagePath: "assets/images/kav.jpg"), height: this._itemSize, width: this._itemSize),
                                        width: this._itemSize,
                                        color: Colors.transparent,
                                    ),
                                    Container
                                    (
                                        margin: EdgeInsets.only(right: 7),
                                        child: ItemComponent(new ShopItem(name: "Frappe", price: 150, imagePath: "assets/images/kav.jpg"), height: this._itemSize, width: this._itemSize),
                                        width: this._itemSize,
                                        color: Colors.transparent,
                                    ),
                                    Container
                                    (
                                        margin: EdgeInsets.only(right: 7),
                                        child: ItemComponent(new ShopItem(name: "Espresso", price: 105, imagePath: "assets/images/kav.jpg"), height: this._itemSize, width: this._itemSize),
                                        width: this._itemSize,
                                        color: Colors.transparent,
                                    ),
                                    Container
                                    (
                                        margin: EdgeInsets.only(right: 7),
                                        child: ItemComponent(new ShopItem(name: "Latte", price: 400, imagePath: "assets/images/kav.jpg"), height: this._itemSize, width: this._itemSize),
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
        this._itemSize = 180;
    }
}