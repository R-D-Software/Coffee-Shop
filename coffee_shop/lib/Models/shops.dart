import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/string_service.dart';
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
  final int closesHour;
  final int opensHour;
  final int closesMinute;
  final int opensMinute;
  final List<String> boxes;

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
        @required this.closesHour,
        @required this.opensHour,
        @required this.closesMinute,
        @required this.opensMinute,
        @required this.boxes,
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
        'closes': StringService.toDateFormatNumber(closesHour) + ":" + StringService.toDateFormatNumber(closesMinute),
        'opens': StringService.toDateFormatNumber(opensHour) + ":" + StringService.toDateFormatNumber(opensMinute),
        'boxes': boxes,
        'appIdentifier': 'Renao',
    };
  }

  factory Shop.fromJson(Map<String, Object> doc, String docID) {
    int closesHour = StringService.intFromDateFormat(doc["closes"].toString().split(":")[0]);
    int closesMinute = StringService.intFromDateFormat(doc["closes"].toString().split(":")[1]);
    int opensHour = StringService.intFromDateFormat(doc["opens"].toString().split(":")[0]);
    int opensMinute = StringService.intFromDateFormat(doc["opens"].toString().split(":")[1]);

    Shop shop = Shop
    (
      buildingNumber: doc['buildingNumber'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      place: doc['place'],
      street: doc['street'],
      imageURL: doc['imageURL'],
      maximumOrderPerMinute: doc['maximumOrderPerMinute'],
      closesHour: closesHour,
      closesMinute: closesMinute,
      opensHour: opensHour,
      opensMinute: opensMinute,
      docID: docID,
      boxes: doc["boxes"] != null
          ? List.from(doc["boxes"])
          : new List<String>()
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
