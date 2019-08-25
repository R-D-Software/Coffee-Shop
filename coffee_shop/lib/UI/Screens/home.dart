import 'package:coffee_shop/UI/Components/BottomNavigationBarComponent.dart';
import 'package:coffee_shop/UI/Components/Home/cart.dart';
import 'package:coffee_shop/UI/Components/Home/item_slider.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Home extends StatelessWidget 
{
    @override
    Widget build(BuildContext context) 
    {
        MediaQueryData mQueryData = MediaQuery.of(context);
    
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
                        ItemSlider("Coffee"),
                        ItemSlider("Breakfast"),
                        ItemSlider("Today's Deals"),
                        ItemSlider("Coffee Again"),
                    ],
                ),
                bottomNavigationBar: BottomNavigationBarComponenet(), 
            ),
            decoration: BoxDecoration
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
            ),
        );
    }
}