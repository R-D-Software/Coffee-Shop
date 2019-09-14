import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryComponent extends StatefulWidget 
{
    @override
    _PurchaseHistoryComponentState createState() => _PurchaseHistoryComponentState();
}

class _PurchaseHistoryComponentState extends State<PurchaseHistoryComponent> 
{
    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            width: MediaQuery.of(context).size.width*0.98,
            height: MediaQuery.of(context).size.height - 70 - 64 - 50,
            child: ListView
            (
                children: <Widget>
                [
                    Container
                    (
                        child: StrokedText(text: LanguageModel.purchaseHistory[LanguageModel.currentLanguage], size: 20),
                        margin: EdgeInsets.all(10),
                    ),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                    getHistoryElement(context),
                ],
            )
        );
    }

    Widget getHistoryElement(BuildContext context)
    {
        return Container
        (
            height: 45,
            child: Card
            (
                color: Colors.transparent,
                child: Row
                (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>
                    [
                        Padding
                        (
                            padding: const EdgeInsets.only(left: 10),
                            child: StrokedText(text: "Aug 7"),
                        ),
                        StrokedText(text: "Latte"),
                        Padding
                        (
                            padding: const EdgeInsets.only(right: 10),
                            child: StrokedText(text: "250 HUF"),
                        ),
                    ],
                ),
            ),
        );
    }
}