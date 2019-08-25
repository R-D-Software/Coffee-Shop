import 'package:coffee_shop/UI/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() 
{

    //Külön külön kommentezd ki
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    //Külön külön kommentezd ki
    /*
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.pink, // status bar color
    ));
    */

    runApp(MyApp());
} 

class MyApp extends StatelessWidget
{
    @override
    Widget build(BuildContext context) 
    {
        return MaterialApp
        (
            theme: ThemeData
            (
                primaryColor: Color.fromRGBO(76,53,47, 1),
                accentColor: Color.fromRGBO(171,122,91, 1), 
                textTheme: TextTheme
                (
                    body1: TextStyle
                    (
                        fontFamily: "Roboto",
                        fontSize: 20
                    )
                ),
                iconTheme: IconThemeData
                (
                    color: Colors.white,
                    opacity: 1,
                    size: 39
                )
            ),
            home: Container
            (
                child: Home()
            )
        );
    }
}