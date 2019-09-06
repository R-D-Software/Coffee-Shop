import 'package:flutter/material.dart';

class StrokedText extends StatelessWidget
{
    final String text;
    final double size;
    final Color color;
    final FontWeight fontWeight;

    StrokedText({@required this.text, this.size, this.color, this.fontWeight});

    @override
    Widget build(BuildContext context)
    {
        return Text
        (
            text,
            textAlign: TextAlign.center,
            style: TextStyle
            (
                color: this.color == null ? Colors.white : this.color,
                fontSize: this.size == null ? 20 : this.size,
                fontFamily: Theme.of(context).textTheme.body1.fontFamily,
                fontWeight: this.fontWeight == null ? FontWeight.normal : this.fontWeight,
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