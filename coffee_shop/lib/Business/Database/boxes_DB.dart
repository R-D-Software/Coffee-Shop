import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/post_box.dart';
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

    static void tryToOpen(String boxID, BuildContext context) async 
    {
        PostBox box = await getBoxByIDFuture(boxID);
        if(box != null)
        {
            if(box.open == false)
            {
                await showDialog
                (
                    context: context,
                    builder: (context)
                    {
                        return AlertDialog
                        (
                            title: Text(LanguageModel.openTheBox[LanguageModel]),
                            content: Text(LanguageModel.areYouSureToOpen[LanguageModel]),
                            actions: <Widget>
                            [
                                FlatButton
                                (
                                    child: Text(LanguageModel.yes[LanguageModel.currentLanguage]),
                                    onPressed: ()
                                    {
                                        Navigator.of(context).pop(true);
                                    },
                                ),
                                FlatButton
                                (
                                    child: Text(LanguageModel.no[LanguageModel.currentLanguage]),
                                    onPressed: ()
                                    {
                                        Navigator.of(context).pop(false);
                                    },
                                )
                            ],
                        );
                    }
                );
                _openBox(boxID);
            }
        }
    }

    static void _openBox(String boxID) 
    {
        Firestore.instance.collection("boxes").document(boxID).updateData({"open": true, "empty" : true});
    }
}
