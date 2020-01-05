import 'dart:io';

import 'package:flutter/material.dart';

class SugarType extends StatefulWidget 
{
    double _height;
    String imagePath;
    Function callback;

    SugarType(this._height, this.imagePath, this.callback);

    @override
    _SugarTypeState createState() => _SugarTypeState();
}

class _SugarTypeState extends State<SugarType> with SingleTickerProviderStateMixin 
{
    AnimationController _controller;

    @override
    void initState() 
    {
        super.initState();
        _controller = AnimationController(vsync: this);
    }

    @override
    void dispose() 
    {
        super.dispose();
        _controller.dispose();
    }

    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            height: widget._height,
            child: GestureDetector
            (
                child: Image.asset(widget.imagePath),
                onTap: (){widget.callback(widget.imagePath);},
            ),
        );
    }
}