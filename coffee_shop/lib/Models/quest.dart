import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Quest
{
    @required int numberOfPieciesRow;
    @required int numberOfPieciesColumn;
    @required int completedParts;
    @required int calendarWeek;
    @required String questItemID;
    @required String imgPath;
    @required String questItemName;

    Quest({this.numberOfPieciesRow, this.numberOfPieciesColumn, this.completedParts, this.calendarWeek, this.imgPath, this.questItemID, this.questItemName});

    factory Quest.fromDocument(DocumentSnapshot questDocumentSnapshot, int completedQuestPart)
    {
        return Quest
        (
            imgPath: 'assets/images/quest_coffee.png', 
            numberOfPieciesColumn: questDocumentSnapshot["column"] as int,
            numberOfPieciesRow: questDocumentSnapshot["row"] as int,
            completedParts: completedQuestPart,
            calendarWeek: questDocumentSnapshot["calendarWeek"],
            questItemID: questDocumentSnapshot["questItemID"].toString(),
            questItemName: questDocumentSnapshot["questItemName"].toString()
        );
    }

    int missingParts() 
    {
        int ret = (numberOfPieciesColumn*numberOfPieciesRow)-completedParts;

        if(ret < 0)
        {
            ret = 0;
        }

        return ret;
    }
}