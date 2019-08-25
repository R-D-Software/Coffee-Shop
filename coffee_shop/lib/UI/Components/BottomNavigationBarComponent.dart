import 'package:flutter/material.dart';

class BottomNavigationBarComponenet extends StatefulWidget 
{
    @override
    _BottomNavigationBarComponenetState createState() => _BottomNavigationBarComponenetState();
}

class _BottomNavigationBarComponenetState extends State<BottomNavigationBarComponenet> 
{
    @override
    Widget build(BuildContext context) 
    {
        return BottomNavigationBar
        (
            backgroundColor: Colors.white,
            elevation: 4,

            currentIndex: 0,
            items: 
            [
                BottomNavigationBarItem
                (
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                ),
                BottomNavigationBarItem
                (
                    icon: new Icon(Icons.mail),
                    title: new Text('Messages'),
                ),
                BottomNavigationBarItem
                (
                    icon: Icon(Icons.person),
                    title: Text('Profile')
                )
            ],
        );
    }
}