import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/food_item.dart';
import 'package:coffee_shop/UI/Screens/coffee_item_view_screen.dart';
import 'package:flutter/foundation.dart';

import 'coffee_Item.dart';

class ShopItem {
  final String documentID;
  final String name;
  final int price;
  final String imageUrl;
  final String description;
  final String itemType;
  final bool onSale;
  final String parentID;

  ShopItem({
    @required this.documentID,
    @required this.name,
    @required this.price,
    @required this.imageUrl,
    @required this.description,
    @required this.itemType,
    @required this.onSale,
    @required this.parentID,
  });

  Map<String, Object> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'itemType': itemType,
      'onSale': onSale,
      'parentID': parentID,
      'appIdentifier': 'Renao'
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory ShopItem.fromJson(Map<String, Object> doc, String documentID) {
    ShopItem item = new ShopItem(
      documentID: documentID,
      name: doc['name'],
      price: doc['price'],
      imageUrl: doc['imageUrl'],
      description: doc['description'],
      itemType: doc['itemType'],
      onSale: doc['onSale'],
      parentID: doc['parentID'],
    );
    return item;
  }

  factory ShopItem.fromCartItemJson(Map<dynamic, dynamic> doc) {
    ShopItem item = null;
    switch (doc['itemType'])
    {
        case "coffee": 
            item = CoffeeItem.fromJson(doc, doc['parentID']);
        break;
        case "food": 
            item = FoodItem.fromJson(doc, doc['parentID']);
        break;
    }
    return item;
  }

  factory ShopItem.fromDocument(DocumentSnapshot doc, String documentID) {
    return ShopItem.fromJson(doc.data, documentID);
  }

  ShopItem asReward() {
    return new ShopItem(
      documentID: this.documentID,
      name: this.name,
      price: 0,
      imageUrl: this.imageUrl,
      description: this.description,
      itemType: this.itemType,
      onSale: this.onSale,
      parentID: this.parentID,
    );
  }

  CoffeeItem toCoffeItem(int sugar, Temperature temperature) {
    return CoffeeItem(shopItem: this, temperature: temperature, sugar: sugar);
  }
}
