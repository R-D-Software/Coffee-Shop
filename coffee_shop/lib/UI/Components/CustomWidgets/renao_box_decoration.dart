import 'package:flutter/material.dart';

class RenaoBoxDecoration
{
    static BoxDecoration builder(BuildContext context) 
    {
        return BoxDecoration
        (
            gradient: LinearGradient
            (
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.6, 0.9],
                colors: 
                [
                    Theme.of(context).accentColor,
                    Theme.of(context).accentColor.withOpacity(0.8),
                ],
            ),
        );
    }
}