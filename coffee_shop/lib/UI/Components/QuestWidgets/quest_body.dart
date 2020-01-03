import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/quest_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/quest.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/QuestWidgets/animated_present.dart';
import 'package:flutter/material.dart';
import '../stroked_text.dart';

class QuestBody extends StatelessWidget 
{
    double imageHeight = 270;
    
    @override
    Widget build(BuildContext context) 
    { 
        return StreamBuilder
        (
            stream: QuestDB.getCurrentQuestData().asStream(),
            builder: (context, questSnapshot)
            {   
                if(questSnapshot.connectionState == ConnectionState.waiting)
                {
                    return Container();
                }
                else
                {
                    return StreamBuilder
                    (
                        stream: UserDB.getCurrentUser().asStream(),
                        builder: (context, userSnapshot)
                        {

                            if(userSnapshot.connectionState == ConnectionState.waiting)
                            {
                                return Container();
                            }
                            else
                            {
                                DocumentSnapshot questDocumentSnapshot = questSnapshot.data as DocumentSnapshot;
                                User currentUser = userSnapshot.data as User; 
                                Quest quest = new Quest.fromDocument(questDocumentSnapshot, currentUser.completedQuestPart);                                                                          

                                return StreamBuilder
                                (
                                    stream: QuestDB.getQuestStatusForUser(StaticData.currentUser.userID, quest.calendarWeek).asStream(),
                                    builder: (context, snap)
                                    {
                                        if(snap.connectionState == ConnectionState.waiting)
                                        {
                                            return Container();
                                        }
                                        else
                                        {
                                            QuestStatus questVal = snap.data;
                                            return buildQuestBody(context, quest, currentUser, questVal);
                                        }
                                    },
                                );
                            }  
                        },
                    );
                }
            }, 
        );
    }   
        
    Widget buildQuestBody(BuildContext context, Quest quest, User userSnapshot, QuestStatus questStatus)
    {
        return Container
        (
            child: Stack
            (
                children: <Widget>
                [
                    //if(quest.completedParts == quest.numberOfPieciesColumn* quest.numberOfPieciesRow) firework,
                    Column
                    (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>
                        [
                            _buildTopHeader(context),
                            _buildQuestText(context, quest, questStatus),
                            AnimatedPresent(quest: quest, imageHeight: imageHeight, questStatus: questStatus),
                            _buildAddToCartButton(context, quest, questStatus),
                            SizedBox(height: 0),
                        ]
                    )
                ],
            ),
        );
    }    

    Widget _buildAddToCartButton(BuildContext context, Quest quest, QuestStatus questStatus)
    {
        if(quest.missingParts() > 0 
            || questStatus == QuestStatus.ITEM_ADDED_TO_CART 
            || questStatus == QuestStatus.ITEM_ORDERED
            || questStatus == QuestStatus.ITEM_NOT_ACQUIRED)
        {
            return Container();
        }

        if(questStatus == QuestStatus.ITEM_ACQUIRED_NOT_USED)
        {
            return Container
            (
                alignment: Alignment.bottomCenter,
                child: ButtonTheme(
                    buttonColor: Color.fromRGBO(231, 82, 100, 1),
                    minWidth: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    elevation: 5,
                    onPressed:() async
                    {
                        ShopItem rewardItem;
                        
                        await ShopItemDB.getShopItemByID(quest.questItemID).first.then((item)=> rewardItem = item);

                        if(rewardItem.itemType == "coffee")
                        {
                            Navigator.of(context).pushNamed("/main/itemview/" + rewardItem.itemType,
                                arguments: {"item": rewardItem.asReward().toCoffeItem(2, Temperature.warm()), "buttonLabel": LanguageModel.add[LanguageModel.currentLanguage], "quest": quest});        
                        }
                        else if (rewardItem.itemType == "food")
                        {
                            Navigator.of(context).pushNamed("/main/itemview/" + rewardItem.itemType,
                                arguments: {"item": rewardItem.asReward(), "buttonLabel": LanguageModel.add[LanguageModel.currentLanguage], "quest": quest});
                        }           
                    },
                    child: Text(
                        LanguageModel.addToCart[LanguageModel.currentLanguage],
                        style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    ),
                ),
            );
        }
    }

    Widget _buildQuestText(BuildContext context, Quest quest, QuestStatus questStatus)
    {
        String questText = "";
        switch(questStatus)
        {
            case QuestStatus.ITEM_NOT_ACQUIRED:
                questText = LanguageModel.questOrder(quest.missingParts(), quest.questItemName);
            break;

            case QuestStatus.ITEM_ACQUIRED_NOT_USED:
                questText = LanguageModel.questComplete[LanguageModel.currentLanguage];
            break;

            case QuestStatus.ITEM_ADDED_TO_CART:
                questText = LanguageModel.questComplete[LanguageModel.currentLanguage];
            break;

            case QuestStatus.ITEM_ORDERED:
                questText = LanguageModel.questCompleteAndOrdered[LanguageModel.currentLanguage];
            break;
        }

        return Padding
        (
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container
            (
                child: StrokedText(text: questText, capsOn: true)
            ),
        );
    }

    Widget _buildTopHeader(BuildContext context)
    {
        return CustomPaint
        (
            child: Container
            (
                color: Colors.transparent,
                child: Align
                (
                    alignment: Alignment.center,
                    child: Container
                    (
                        child: StrokedText(text: LanguageModel.coffeeOfTheWeek[LanguageModel.currentLanguage], size: 25)
                    )
                ),
                height: 50),
            painter: CurvePainter(context),
        );
    }
}

class CurvePainter extends CustomPainter 
{
    final BuildContext context;

    CurvePainter(this.context);

    @override
    void paint(Canvas canvas, Size size) 
    {
        Path path = Path();
        Paint paint = Paint();

        MediaQueryData mQueryData = MediaQuery.of(context);

        double width = mQueryData.size.width;

        List<Offset> polygon = <Offset>[
        new Offset(40, 0),
        new Offset(40, 25),
        new Offset(70, 50),
        new Offset(width - 70, 50),
        new Offset(width - 40, 25),
        new Offset(width - 40, 0)
        ];

        path.addPolygon(polygon, true);
        path.close();

        LinearGradient grad = LinearGradient(colors: <Color>[
        Theme.of(context).primaryColor.withOpacity(1),
        Colors.brown,
        Theme.of(context).primaryColor.withOpacity(1),
        ], end: Alignment.bottomRight, begin: Alignment.topLeft);

        paint.shader = grad.createShader(Rect.fromLTWH(0, 0, width, 60));
        canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) 
    {
        return oldDelegate != this;
    }
}
