import 'package:flutter/material.dart';

class TemperatureChooser extends StatefulWidget 
{
    @override
    _TemperatureChooserState createState() => _TemperatureChooserState();
}

class _TemperatureChooserState extends State<TemperatureChooser> 
{
    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            margin: EdgeInsets.only(bottom: 10),
        	child: Row
            (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                    temperatureCube(),
                    temperatureCube()
                ],
            ),
        );
    }

    Widget temperatureCube()
    {
        return Card
        (
            elevation: 2,
            child: Container
            (
                child: Image.asset("assets/images/kav.jpg"),
                width: 50,
                height: 50,
                decoration: BoxDecoration
                (
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
                ),  
            ),
        );
    }
}