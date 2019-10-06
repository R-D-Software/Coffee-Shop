import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestDB
{

    static Stream<QuerySnapshot> getCurrentQuestData()
    {
        return Firestore.instance.collection("quest").snapshots();
    }
}