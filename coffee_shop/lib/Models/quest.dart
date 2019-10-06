import 'package:flutter/foundation.dart';

class Quest
{
    @required int numberOfPieciesRow;
    @required int numberOfPieciesColumn;
    @required int completedParts;
    @required String questItemID;
    @required String imgPath;
    @required String questItemName;

    Quest({this.numberOfPieciesRow, this.numberOfPieciesColumn, this.completedParts, this.imgPath, this.questItemID, this.questItemName});

    int missingParts() 
    {
        if(numberOfPieciesColumn == null || numberOfPieciesRow == null || completedParts == null)
            return 10;

        return (numberOfPieciesColumn*numberOfPieciesRow)-completedParts;
    }
}