import 'package:flutter/material.dart';

class SugarChooser extends StatefulWidget 
{
    @override
    _SugarChooserState createState() => _SugarChooserState();
}

class _SugarChooserState extends State<SugarChooser> 
{
    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            width: double.infinity,
            height: 75,
            child: Row
            (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: 
                [
                    Icon(Icons.remove),
                    
                    sugarCube(),
                    sugarCube(),
                    sugarCube(),
                    sugarCube(),              
                 
                    Icon(Icons.add),
                ]
            ),
        );
    }

    Widget sugarCube()
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