import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

class CoffeeItem extends ShopItem {
  Temperature temperature;
  int itemCount;
  int sugar;

  CoffeeItem({ShopItem shopItem, @required this.temperature, @required this.itemCount, @required this.sugar})
      : super(
            id: shopItem.id,
            imagePath: shopItem.imagePath,
            name: shopItem.name,
            price: shopItem.price);
}

class Temperature {
  String temperature;
  Color color;

  Temperature.iceCold() {
    temperature = "ice cold";
    color = Colors.lightBlueAccent;
  }

  Temperature.cold() {
    temperature = "cold";
    color = Colors.blueAccent;
  }

  Temperature.warm() {
    temperature = "warm";
    color = Colors.redAccent;
  }

  Temperature.hot() {
    temperature = "hot";
    color = Colors.red;
  }
}
