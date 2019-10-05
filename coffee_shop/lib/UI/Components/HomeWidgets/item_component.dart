import 'dart:ui';

import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

class ItemComponent extends StatelessWidget {
  final ShopItem item;
  final double height;
  final double width;

  ItemComponent(this.item, {this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 4,
      child: GestureDetector(
        onTap: () => {_navigateToItemView(context)},
        child: Container(
          child: Stack(children: <Widget>[
            GestureDetector(
              child: Container(
                  width: this.width,
                  height: this.height,
                  margin: EdgeInsets.all(7),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/images/minussign.png",
                        width: 24.0,
                        height: 24.0,
                      ))),
              onTap: () => {},
            ),
            Container(
                width: this.width,
                height: this.height,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: height * 0.23,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: detailsText(item.name),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: detailsText(item.price.toString() + "Ft"),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(84, 84, 84, 0.85),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18.0), bottomRight: Radius.circular(18.0), topLeft: Radius.zero, topRight: Radius.zero)),
                    ))),
          ]),
          decoration: BoxDecoration(image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(this.item.imageUrl)), borderRadius: BorderRadius.all(Radius.circular(18.0))),
        ),
      ),
    );
  }

  Widget detailsText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: height * 0.085),
    );
  }

  void _navigateToItemView(BuildContext context) {
    Navigator.of(context).pushNamed("/main/itemview/${item.itemType}", arguments: {"itemID": item.documentID});
  }
}
