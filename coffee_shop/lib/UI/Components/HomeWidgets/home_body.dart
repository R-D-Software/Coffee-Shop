import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

import 'cart.dart';
import 'item_slider.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> 
{
    List<ShopItem> _items = 
    [
        new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg"),
        new ShopItem(name: "cica", price: 5, imagePath: "assets/images/kav.jpg"),
    ];

    @override
    Widget build(BuildContext context) {
        _items.clear();

        return ListView(
        children: <Widget>
        [
            Cart(_items),
            ItemSlider("Coffee"),
            ItemSlider("Breakfast"),
            ItemSlider("Today's Deals"),
            ItemSlider("Coffee Again"),
        ],
        );
    }
}