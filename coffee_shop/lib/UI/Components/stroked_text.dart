import 'package:flutter/material.dart';

class StrokedText extends StatelessWidget
{
    final String text;
    final double size;
    final Color color;

    StrokedText({@required this.text, this.size, this.color});

    @override
    Widget build(BuildContext context)
    {
        return Text
        (
            text,
            textAlign: TextAlign.center,
            style: TextStyle
            (
                color: this.color == null? Colors.white : color,
                fontSize: this.size == null? 20 : size,
                fontFamily: Theme.of(context).textTheme.body1.fontFamily,
                shadows: <Shadow>
                [
                    Shadow
                    (
                        offset: Offset(1.0, 2.0),
                        blurRadius: 6.0,
                        color: Colors.brown,
                    )
                ]
            ),
        );
    }
}