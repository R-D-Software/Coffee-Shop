import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostBox {
    String boxID;
    int number;
    String ownerUserID;
    bool empty;
    String shopID; 
    bool open; 
    bool itemsRetreived; 

    PostBox({@required this.number, @required this.ownerUserID, @required this.empty, @required this.shopID, @required this.open, @required this.boxID, @required this.itemsRetreived});

    factory PostBox.fromJson(Map<String, Object> doc, String boxID) {
        return PostBox(
        boxID: boxID,
        number: doc['number'],
        ownerUserID: doc['ownerUserID'],
        empty: doc['empty'],
        shopID: doc['shop'],
        open: doc['open'],
        itemsRetreived: doc['itemsRetreived'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['number'] = this.number;
        data['ownerUserID'] = this.ownerUserID;
        data['empty'] = this.empty;
        data['shop'] = this.shopID;
        data['open'] = this.open;
        data['itemsRetreived'] = this.itemsRetreived;
        return data;
    }

    factory PostBox.fromDocument(DocumentSnapshot doc, String boxID) {
        return PostBox.fromJson(doc.data, boxID);
    }
}
