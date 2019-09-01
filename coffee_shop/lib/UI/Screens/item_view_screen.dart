import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_chooser.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/temperature_chooser.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class ItemViewScreen extends StatelessWidget 
{
    @override
    Widget build(BuildContext context) 
    {
        MediaQueryData mData = MediaQuery.of(context);       
        double height = 0;
        if(mData.orientation == Orientation.portrait)
        {
            height = mData.size.height;
        }
        else
        {
            height = mData.size.width;
        }

        return Scaffold
        (
            appBar: AppBar(),
            body: SingleChildScrollView
            (
                scrollDirection: Axis.vertical,
                child: Container
                (
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
                    height: height*0.92,
                    child: Column
                    (
                        children: <Widget>
                        [
                            Row
                            (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>
                                [
                                    Icon(Icons.keyboard_arrow_left),
                                    StrokedText
                                    (
                                        text: "dsadas",
                                        color: Colors.white,
                                        size: 25,
                                    ),
                                    Icon(Icons.keyboard_arrow_right),
                                ],
                            ),
                            Stack
                            (
                                alignment: Alignment.topCenter,
                                children: <Widget>
                                [
                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 20, bottom: 25),
                                        width: height*0.35,
                                        height: height*0.35,
                                        decoration: new BoxDecoration
                                        (
                                            boxShadow:  
                                            [
                                                new BoxShadow
                                                (
                                                    color: Colors.red,
                                                    spreadRadius: 2,
                                                    offset: new Offset(-5.0, 10.0),
                                                )
                                            ],
                                            border: Border.all(color: Theme.of(context).primaryColor, width: 14),
                                            shape: BoxShape.circle,
                                            image: new DecorationImage
                                            (
                                                fit: BoxFit.fill,
                                                image: new NetworkImage("https://i.imgur.com/BoN9kdC.png")
                                            )
                                        )
                                    ),
                                    Container
                                    (
                                        child: Icon
                                        (
                                            Icons.star,
                                            size: 50,
                                            color: Colors.white,
                                        ),
                                        margin: EdgeInsets.only(top: 2),
                                    )
                                ],
                            ),


                            Container
                            (
                                margin: EdgeInsets.only(bottom: 0),
                                child: StrokedText
                                (
                                    text: "Sugar",
                                    color: Colors.white,
                                    size: 25,
                                ),
                            ),

                            SugarChooser(),

                            Container
                            (
                                margin: EdgeInsets.only(bottom: 10),
                                child: StrokedText
                                (
                                    text: "Temperature",
                                    color: Colors.white,
                                    size: 25,
                                ),
                            ),

                            TemperatureChooser(),

                            ButtonTheme
                            (
                                buttonColor: Color.fromRGBO(231,82,100, 1),
                                minWidth: MediaQuery.of(context).size.width-20,
                                height: 40.0,
                                child: RaisedButton
                                (	
                                    shape: RoundedRectangleBorder
                                    (
                                        side: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    elevation: 5,
                                    onPressed: () {},
                                    child: Text
                                    (
                                        "ADD",
                                        style: TextStyle
                                        (
                                            fontSize: 25,
                                            color: Colors.white
                                        ),
                                    ),
                                ),
                            )
                        ],
                    ),
                    width: double.infinity,
                ),
            ),
        );
    }
}