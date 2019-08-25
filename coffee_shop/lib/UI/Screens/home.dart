import 'package:coffee_shop/UI/Components/cart.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Home extends StatelessWidget 
{
    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            child: Scaffold
            (
                backgroundColor: Colors.transparent,
                appBar: GradientAppBar
                (
                    backgroundColorStart: Colors.brown,
                    backgroundColorEnd: Theme.of(context).accentColor,
                    bottom: PreferredSize
                    (
                        child: Container
                        (
                            color: Colors.orange, height: 4.0,
                        ), 
                        preferredSize: Size.fromHeight(4.0)
                    ),



                    title: Row
                    (
                        children: <Widget>
                        [
                            IconButton
                            (
                                icon: Icon
                                (
                                    Icons.menu,
                                    color: Theme.of(context).accentColor,
                                    size: 35,
                                ),
                                onPressed: null,
                            ),
                            Container
                            (
                                margin: EdgeInsets.only(left: 14),
                                child: StrokedText
                                (
                                    text: "Home",
                                    size: 40
                                ),
                            ),
                        ],
                    ),
                ),

                

               body: ListView
               (
                   children: <Widget>
                   [
                       Cart(),
                   ],
               ),
            ),
            decoration: BoxDecoration
            ( 
                gradient: LinearGradient
                (
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.75],
                    colors: 
                    [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                    ],
                ),
            ),
        );
    }
}