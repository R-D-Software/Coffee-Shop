import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class RenaoEmptyList extends StatelessWidget 
{
    final String imagePath;
    final String textHeader;
    final String textDescription;

    RenaoEmptyList({@required this.imagePath, @required this.textHeader, @required this.textDescription});


    @override
    Widget build(BuildContext context) 
    {
        double width = MediaQuery.of(context).size.width;
        return Container
        (
            child: Center
            (
                child: Column
                (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>
                    [
                        ClipRRect
                        (
                            borderRadius: BorderRadius.circular(200.0),
                            child: Card
                            (
                                elevation: 2,
                                child: Image.asset(this.imagePath, width: width*0.75,),
                            ),
                        ),
                        SizedBox(height: 10,),
                        StrokedText
                        (
                            text: this.textHeader,
                            size: 30,
                        ),
                        Container
                        (
                            margin: EdgeInsets.only(left: width*0.11, right: width*0.11, top: 25),
                            child: Text
                            (
                                this.textDescription,
                                textAlign: TextAlign.center,
                                style: TextStyle
                                (
                                    color: Colors.white70
                                ),
                            ),
                        ),
                        SizedBox(height: width*0.07)
                    ],
                ),
            ),
        );
    }

}