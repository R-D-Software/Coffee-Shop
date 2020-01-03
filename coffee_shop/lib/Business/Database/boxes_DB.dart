import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/post_box.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_dialog.dart';
import 'package:flutter/material.dart';

enum OpenBoxStatus { USER_NO, USER_YES, BOX_IS_OPEN, ERROR_HAPPENED }

class BoxesDB {
  static Stream fetchBoxes() {
    return Firestore.instance.collection("boxes").snapshots();
  }

  static addBox(PostBox box) {
    Firestore.instance.collection("boxes").document().setData(box.toJson());
  }

  static Stream<DocumentSnapshot> getBoxByID(String boxID) {
    if (boxID != "-1") {
      return Firestore.instance.collection("boxes").document(boxID).snapshots();
    }

    return null;
  }

  static Future<PostBox> getBoxByIDFuture(String boxID) async {
    DocumentSnapshot ds =
        await Firestore.instance.collection("boxes").document(boxID).get();
    return PostBox.fromDocument(ds, boxID);
  }

  static Future<OpenBoxStatus> tryToOpen(
      String boxID, String orderID, BuildContext context) async {
    PostBox box = await getBoxByIDFuture(boxID);
    bool answer = false;

    if (box.ownerUserID != StaticData.currentUser.userID)
      return OpenBoxStatus.ERROR_HAPPENED;

    if (box != null) {
      if (box.open == false) {
        answer = await RenaoDialog.showOpenDialog(context);

        if (answer == true) {
          _openBoxUser(boxID, orderID);
          return OpenBoxStatus.USER_YES;
        } else {
          return OpenBoxStatus.USER_NO;
        }
      } else {
        return OpenBoxStatus.BOX_IS_OPEN;
      }
    }
    return OpenBoxStatus.ERROR_HAPPENED;
  }

  ///DO NOT USE THIS FUNCTION FOR OPENING THE BOX AS AN ADMIN
  static Future _openBoxUser(String boxID, String orderID) async {
    Firestore.instance
        .collection("boxes")
        .document(boxID)
        .updateData({"open": true, "empty": true, "itemsRetrieved": true});
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .updateData({
      "currentOrders": FieldValue.arrayRemove([orderID])
    });
  }
}
