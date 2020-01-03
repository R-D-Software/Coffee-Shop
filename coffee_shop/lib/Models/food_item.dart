import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

class FoodItem extends ShopItem {
  FoodItem({
    @required ShopItem shopItem,
  }) : super(
            documentID: shopItem.documentID,
            imageUrl: shopItem.imageUrl,
            name: shopItem.name,
            price: shopItem.price,
            description: shopItem.description,
            itemType: "food",
            onSale: shopItem.onSale,
            parentID: shopItem.parentID);

  Map<String, Object> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'itemType': itemType,
      'onSale': onSale,
      'parentID': parentID,
      'appIdentifier': 'Renao',
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory FoodItem.fromJson(Map<dynamic, dynamic> doc, String documentID) {
    FoodItem item = FoodItem(
      shopItem: ShopItem(
        documentID: documentID,
        name: doc['name'],
        price: doc['price'],
        imageUrl: doc['imageUrl'],
        description: doc['description'],
        onSale: doc['onSale'],
        itemType: doc['itemType'],
        parentID: doc['parentID'],
      ),
    );
    return item;
  }

  factory FoodItem.fromDocument(DocumentSnapshot doc, String documentID) {
    return FoodItem.fromJson(doc.data, documentID);
  }
}
