import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ShopItem
{
    final String name;
    final String itemID;
    final int price;
    final String imageUrl;
    final String description;
    final String itemType;
    final bool onSale;

    ShopItem
    (
    	{
            @required this.name, 
            @required this.itemID, 
            @required this.price,
            @required this.imageUrl, 
            @required this.description, 
            @required this.itemType,
            @required this.onSale,
        }
    );

    Map<String, Object> toJson() 
    {
        return
        {
            'name': name,
            'itemID': itemID,
            'price': price,
            'imageUrl': imageUrl,
            'description': description,
            'itemType': itemType,
            'onSale': onSale,
            'appIdentifier': 'Renao'
        };
    }

    factory ShopItem.fromJson(Map<String, Object> doc, String documentID) 
    {
        ShopItem item = new ShopItem
        (
            name: doc['name'],
            itemID: doc['itemID'],
            price: doc['price'],
            imageUrl: doc['imageUrl'],
            description: doc['description'],
            itemType: doc['itemType'],
            onSale: doc['onSale'],
        );
        return item;
    }

    factory ShopItem.fromDocument(DocumentSnapshot doc, String documentID) 
    {
        return ShopItem.fromJson(doc.data, documentID);
    }
}