import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostBox {
  String documentID;
  int number;
  String ownerUserID;
  bool empty;

  PostBox({@required this.number, @required this.ownerUserID, @required this.empty});

  factory PostBox.fromJson(Map<String, Object> doc, String documentID) {
    return PostBox(
      number: doc['number'],
      ownerUserID: doc['ownerUserID'],
      empty: doc['empty'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['ownerUserID'] = this.ownerUserID;
    data['empty'] = this.empty;
    return data;
  }

  factory PostBox.fromDocument(DocumentSnapshot doc, String documentID) {
    return PostBox.fromJson(doc.data, documentID);
  }
}
