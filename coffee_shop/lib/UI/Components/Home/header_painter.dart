import 'package:flutter/material.dart';

import '../stroked_text.dart';
class HeaderPainter extends StatelessWidget 
{
    final double maxHeight;
    final double height;
    final double width;
    final double heightBreak;
    final String name;
    final Icon icon;

    HeaderPainter({@required this.height,@required this.width,@required this.heightBreak,@required this.maxHeight, @required this.name, this.icon});

    @override
    Widget build(BuildContext context) 
    {
        return CustomPaint
        (
            child: Container
            (
                color: Colors.transparent,
                child: Align
                (
                    alignment: Alignment.centerLeft,
                    child: Container
                    (
                        margin: EdgeInsets.only(left: 20.0),
                        child: StrokedText(text: name, size: 30)
                    )
                ),
                height: heightBreak
            ),
            painter: CurvePainter(height, width, context, maxHeight, heightBreak),
        );
    }
}

class CurvePainter extends CustomPainter
{
    final double height;
    final double width;
    final double maxHeight;
    final double heightBreak;
    final BuildContext context;

    CurvePainter(this.height, this.width, this.context, this.maxHeight, this.heightBreak);

    @override
    void paint(Canvas canvas, Size size) 
    {
        Path path = Path();
        Paint paint = Paint();

        List<Offset> polygon = <Offset>
        [
            new Offset(0, 0),
            new Offset(0, heightBreak),
            new Offset(width*0.72, heightBreak),
            new Offset(width, maxHeight),
            new Offset(width, 0)
        ];

        path.addPolygon(polygon, true);
        path.close();

        LinearGradient grad = LinearGradient
        (
            colors: <Color>
            [
                Colors.brown,
                Theme.of(context).accentColor.withOpacity(1)
            ],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft
        );

        /*LinearGradient grad = LinearGradient
        (
            colors: <Color>
            [
                Colors.brown,
                Theme.of(context).accentColor
            ],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft
        );*/

        paint.shader = grad.createShader(Rect.fromLTWH(0, 0, width, maxHeight));
        canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) 
    {
        return oldDelegate != this;
    }
}