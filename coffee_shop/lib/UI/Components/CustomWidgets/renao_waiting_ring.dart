import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RenaoWaitingRing extends StatelessWidget 
{
    @override
    Widget build(BuildContext context) 
    {
        return new Center
        (
            child: SpinKitRing
            (
                size:30,
                color: Colors.grey,
            ),
        );
    }
}