import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ShopItem {
  final String documentID;
  final String name;
  final int price;
  final String imageUrl;
  final String description;
  final String itemType;
  final bool onSale;

  ShopItem({
    @required this.documentID,
    @required this.name,
    @required this.price,
    @required this.imageUrl,
    @required this.description,
    @required this.itemType,
    @required this.onSale,
  });

  Map<String, Object> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'itemType': itemType,
      'onSale': onSale,
      'appIdentifier': 'Renao'
    };
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
    );
    return item;
  }

  factory ShopItem.fromDocument(DocumentSnapshot doc, String documentID) {
    return ShopItem.fromJson(doc.data, documentID);
  }

    ShopItem asReward() 
    {
        return new ShopItem
        (
            documentID: this.documentID,
            name: this.name,
            price: 0,
            imageUrl: this.imageUrl,
            description: this.description,
            itemType: this.itemType,
            onSale: this.onSale,
        );
    }
}
