import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class BalanceComponent extends StatelessWidget 
{
    @override
    Widget build(BuildContext context) 
    {
        return Card
        (
            child: Container
            (
                width: double.infinity,
                height: 70,
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
                    child: StrokedText(text: "Your Balance: " + "50000", size: 28,)
                ),
            ),
            elevation: 3
        );
    }
}