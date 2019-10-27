import 'package:flutter/material.dart';

import '../stroked_text.dart';
class HeaderPainter extends StatelessWidget 
{
    final double maxHeight;
    final double height;
    final double width;
    final double heightBreak;
    final String name;
    final IconData icon;
    final Function onIconClick;

    HeaderPainter({@required this.height,@required this.width,@required this.heightBreak,@required this.maxHeight, @required this.name, this.icon, this.onIconClick});

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
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row
                        (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>
                            [
                                StrokedText(text: name, size: 30),
                                if(icon != null) GestureDetector
                                (
                                    child: Icon(icon),
                                    onTap: onIconClick == null ? log : onIconClick,
                                ) 
                            ],
                        )
                    )
                ),
                height: heightBreak
            ),
            painter: CurvePainter(height, width, context, maxHeight, heightBreak),
        );
    }

    void log()
    {
        print("HeaderPainter GestureDetector onTap: " + name);
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

        paint.shader = grad.createShader(Rect.fromLTWH(0, 0, width, maxHeight));
        canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) 
    {
        return oldDelegate != this;
    }
}