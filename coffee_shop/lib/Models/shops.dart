import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shops
{
    final List<Shop> items;

    Shops({@required this.items});

    factory Shops.fromJson(List<DocumentSnapshot> docs) 
    {
        List<Shop> tempItems = new List<Shop>();

        for(DocumentSnapshot doc in docs)
        {
            tempItems.add(new Shop.fromDocument(doc));
        }

        Shops shops = Shops
        (
            items: tempItems
        );
        return shops;
    }

    factory Shops.fromDocument(List<DocumentSnapshot> docs) 
    {
        return Shops.fromJson(docs);
    }
}

class Shop{

  final String buildingNumber;
  final String latitude;
  final String longitude;
  final String place;
  final String street;
  final String imageURL;
  final String docID;
  final int maximumOrderPerMinute;
  final int closes;
  final int opens;

  Shop
  (
    {
        @required this.buildingNumber,
        @required this.latitude,
        @required this.longitude,
        @required this.place,
        @required this.street,
        @required this.imageURL,
        @required this.docID,
        @required this.maximumOrderPerMinute,
        @required this.closes,
        @required this.opens,
    }
  );

  Map<String, Object> toJson() {
    return {
        'buildingNumber': buildingNumber,
        'latitude': latitude,
        'longitude': longitude,
        'place': place,
        'street': street,
        'imageURL': imageURL,
        'maximumOrderPerMinute': maximumOrderPerMinute,
        'closes': closes,
        'opens': opens,
        'appIdentifier': 'Renao',
    };
  }

  factory Shop.fromJson(Map<String, Object> doc, String docID) {
    Shop shop = Shop
    (
      buildingNumber: doc['buildingNumber'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      place: doc['place'],
      street: doc['street'],
      imageURL: doc['imageURL'],
      maximumOrderPerMinute: doc['maximumOrderPerMinute'],
      closes: doc['closes'],
      opens: doc['opens'],
      docID: docID,
    );
    return shop;
  }

  factory Shop.fromDocument(DocumentSnapshot doc) {
    return Shop.fromJson(doc.data, doc.documentID);
  }

  @override
  String toString()
  {
      return place + " " + street + " " + buildingNumber;
  }
}
