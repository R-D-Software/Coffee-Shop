import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_card.dart';
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
        return SugarCard(height: 50, width: 50,);
    }
}