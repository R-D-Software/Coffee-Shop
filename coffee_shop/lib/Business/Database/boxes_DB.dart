import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/post_box.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:flutter/material.dart';

class BoxesDB {
    static Stream fetchBoxes() {
        return Firestore.instance.collection("boxes").snapshots();
    }

    static addBox(PostBox box) {
        Firestore.instance.collection("boxes").document().setData(box.toJson());
    }

    static Stream<DocumentSnapshot> getBoxByID(String boxID)
    {
        if(boxID != "-1")
        {
            return Firestore.instance.collection("boxes").document(boxID).snapshots();
        }
        
        return null;
    }

    static Future<PostBox> getBoxByIDFuture(String boxID) async
    {
        DocumentSnapshot ds = await  Firestore.instance.collection("boxes").document(boxID).snapshots().first;
        return PostBox.fromDocument(ds, boxID);
    }

    static void tryToOpen(String boxID, String orderID, BuildContext context) async 
    {
        PostBox box = await getBoxByIDFuture(boxID);
        bool answer = false;

        if(box != null)
        {
            if(box.open == false)
            {
                answer = await showDialog
                (
                    barrierDismissible: false,
                    context: context,
                    builder: (context)
                    {
                        return AlertDialog
                        (
                            title: Text(LanguageModel.openTheBox[LanguageModel.currentLanguage]),
                            content: Text(LanguageModel.areYouSureToOpen[LanguageModel.currentLanguage]),
                            actions: <Widget>
                            [
                                FlatButton
                                (
                                    child: Text(LanguageModel.no[LanguageModel.currentLanguage]),
                                    onPressed: ()
                                    {
                                        Navigator.of(context).pop(false);
                                    },
                                ),
                                FlatButton
                                (
                                    child: Text(LanguageModel.yes[LanguageModel.currentLanguage]),
                                    onPressed: ()
                                    {
                                        Navigator.of(context).pop(true);
                                    },
                                )
                            ],
                        );
                    }
                );
                
                if(answer == true)
                {
                    _openBoxUser(boxID, orderID);
                }
            }
        }
    }

    ///DO NOT USE THIS FUNCTION FOR OPENING THE BOX AS AN ADMIN
    static Future _openBoxUser(String boxID, String orderID) async
    {
        Firestore.instance.collection("boxes").document(boxID).updateData({"open": true, "empty" : true, "itemsRetrieved": true});
        Firestore.instance.collection("users").document(StaticData.currentUser.userID).updateData({"currentOrders": FieldValue.arrayRemove([orderID])});
    }
}
