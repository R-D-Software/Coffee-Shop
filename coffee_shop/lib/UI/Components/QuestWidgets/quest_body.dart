import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Cart/decide_item_type.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/quest_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/quest.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/QuestWidgets/animated_present.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../stroked_text.dart';

class QuestBody extends StatelessWidget 
{
    double imageHeight = 270;
    Quest quest;
    
    @override
    Widget build(BuildContext context) 
    { 
        return StreamBuilder
        (
            stream: QuestDB.getCurrentQuestData(),
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
                            return buildQuestBody(context, questSnapshot, userSnapshot);
                        },
                    );
                }
            }, 
        );
    }   
        
    Widget buildQuestBody(BuildContext context, AsyncSnapshot questSnapshot, AsyncSnapshot userSnapshot)
    {
        QuerySnapshot questQuerySnapshot = questSnapshot.data as QuerySnapshot;
        User currentUser = userSnapshot.data as User;

        quest = new Quest
        (
            imgPath: 'assets/images/quest_coffee.png', 
            numberOfPieciesColumn: questQuerySnapshot.documents[0]["column"] as int,
            numberOfPieciesRow: questQuerySnapshot.documents[0]["row"] as int,
            completedParts: currentUser.completedQuestPart,
            questItemID: questQuerySnapshot.documents[0]["questItemID"].toString(),
            questItemName: questQuerySnapshot.documents[0]["questItemName"].toString()
        );

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
                            _buildQuestText(context, quest),
                            AnimatedPresent(quest: quest, imageHeight: imageHeight),
                            _buildAddToCartButton(context),
                            SizedBox(height: 0),
                        ]
                    )
                ],
            ),
        );
    }    

    ///TODO: coffee type must be navigated to modify 
    Widget _buildAddToCartButton(BuildContext context)
    {
        if(quest.missingParts() != 0)
        {
            return Container();
        }

        return Container(
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
                            arguments: {"item": rewardItem.asReward().toCoffeItem(2, Temperature.warm()), "buttonLabel": LanguageModel.add[LanguageModel.currentLanguage]});        
                    }
                    else if (rewardItem.itemType == "food")
                    {
                        CartItemDB.addRewardItemToCart(rewardItem);
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

    Widget _buildQuestText(BuildContext context, Quest quest)
    {
        if(quest.missingParts() == 0)
        {
            return Padding
            (
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container
                (
                    child: StrokedText(text: LanguageModel.questComplete[LanguageModel.currentLanguage], capsOn: true)
                ),
            );
        }

        return Padding
        (
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container
            (
                child: StrokedText(text: LanguageModel.questOrder(quest.missingParts(), quest.questItemName), capsOn: true)
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
