import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class BalanceComponent extends StatelessWidget 
{
    final double height = 70;

    @override
    Widget build(BuildContext context) 
    {
        return Card
        (
            child: Container
            (
                width: double.infinity,
                height: height,
                decoration: BoxDecoration
                (
                    gradient: LinearGradient
                    (
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.6, 0.9],
                        colors: 
                        [
                            Colors.orange[200],
                            Colors.orange[300],
                        ],
                    ),
                ),
                child: Align
                (
                    alignment: Alignment.center,
                    child: StrokedText(text: LanguageModel.yourBalance[LanguageModel.currentLanguage] + "50000", size: 28,)
                ),
            ),
            elevation: 3
        );
    }
}