import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

import 'cart_item_component.dart';
import 'header_painter.dart';

class Cart extends StatefulWidget {
  final List<ShopItem> _items;

  Cart(this._items);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double _maxHeight;
  double _height;
  double _width;
  double _heightBreak;
  double _itemSize;

  @override
  Widget build(BuildContext context) {
    getPropertyValues();

        return Column
        (
            children: 
            [
                HeaderPainter
                (
                	name: LanguageModel.cart[LanguageModel.currentLanguage],
                    width: _width,
                    height: _height,
                    maxHeight: _maxHeight,
                    heightBreak: _heightBreak,
                    icon: Icons.payment,
                ),

                Container
                (
                    margin: EdgeInsets.only(top: 7, bottom: 7),
                    height: this._itemSize,
                    child: ListView
                    (
                        scrollDirection: Axis.horizontal,
                        children: widget._items.isEmpty ? 
                        _getEmptyField()                     
                        :
                        _getItems(widget._items),
                    )
                )
            ]
        );
    }

  void getPropertyValues() {
    MediaQueryData mQueryData = MediaQuery.of(context);

    this._height = mQueryData.size.height;
    this._width = mQueryData.size.width;
    this._maxHeight = 120;
    this._heightBreak = 57;
    this._itemSize = 100;
  }

  List<Widget> _getItems(List<ShopItem> items) {
    return items
        .map((f) => Container(
              margin: EdgeInsets.only(right: 7),
              child: CartItemComponent(f),
              width: this._itemSize,
              color: Colors.transparent,
            ))
        .toList();
  }

    List<Widget> _getEmptyField()
    {
        return <Widget>
        [
            Container
            (
                width: _width,
                child: Row
                (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>
                    [
                        Card
                        (
                            child: ClipRRect
                            (
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset("assets/images/kav.jpg")
                            ),
                            shape:RoundedRectangleBorder
                            (
                                borderRadius: BorderRadius.circular(15.0),
                            )
                        ),
                        StrokedText
                        (
                            text:LanguageModel.noOrder[LanguageModel.currentLanguage],
                            color: Colors.white,
                            size: 25,
                        )
                    ],
                ),
            )
        ];
    }
}