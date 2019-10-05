import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

class CoffeeItem extends ShopItem {
  String documentID;
  Temperature temperature;
  int sugar;

  CoffeeItem(
      {@required ShopItem shopItem,
      @required this.temperature,
      @required this.documentID,
      @required this.sugar})
      : super(
            itemID: shopItem.itemID,
            imageUrl: shopItem.imageUrl,
            name: shopItem.name,
            price: shopItem.price,
            description: shopItem.description,
            itemType: shopItem.itemType,
            onSale: shopItem.onSale);

  Map<String, Object> toJson() {
    return {
      'name': name,
      'itemID': itemID,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'itemType': itemType,
      'onSale': onSale,
      'appIdentifier': 'Renao',
      'temperature': temperature.temperature,
      'sugar': sugar
    };
  }

  factory CoffeeItem.fromJson(Map<String, Object> doc, String documentID) {
    CoffeeItem item = CoffeeItem(
      shopItem: ShopItem(
        name: doc['name'],
        itemID: doc['itemID'],
        price: doc['price'],
        imageUrl: doc['imageUrl'],
        description: doc['description'],
        onSale: doc['onSale'],
        itemType: doc['itemType'],
      ),
      temperature: _setTemperature(doc['temperature']),
      sugar: doc['sugar'],
      documentID: documentID,
    );
    return item;
  }

  factory CoffeeItem.fromDocument(DocumentSnapshot doc, String documentID) {
    return CoffeeItem.fromJson(doc.data, documentID);
  }
}

Temperature _setTemperature(String temperature) {
  switch (temperature) {
    case 'hot':
      return Temperature.hot();
      break;
    case 'warm':
      return Temperature.warm();
      break;
    case 'cold':
      return Temperature.cold();
      break;
    case 'ice cold':
      return Temperature.iceCold();
      break;
  }
  return Temperature.hot();
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
