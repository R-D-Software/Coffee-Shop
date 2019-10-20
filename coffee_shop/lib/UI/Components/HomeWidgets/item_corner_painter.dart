import 'package:flutter/material.dart';

class ItemCornerPainter extends StatelessWidget 
{
    final int orderNo;
    final double itemSize;
    final double radius;

    ItemCornerPainter({this.orderNo, this.itemSize, this.radius});

    @override
    Widget build(BuildContext context) 
    {
        return CustomPaint
        (
            painter: ItemCurvePainter(context, itemSize, radius, orderNo),
        );
    }
}

class ItemCurvePainter extends CustomPainter
{
    final double itemSize;
    final double radius;
    final int orderNo;
    final BuildContext context;

    ItemCurvePainter(this.context, this.itemSize, this.radius, this.orderNo);

    @override
    void paint(Canvas canvas, Size size) 
    {
        Path path = Path();
        Paint paint = Paint();

        List<Offset> polygon = <Offset>
        [
            new Offset(itemSize-40, 0),
        ];

        path.addPolygon(polygon, true);
        path.lineTo(itemSize-8-radius, 0);
        path.cubicTo(itemSize+8-radius, 0, itemSize - radius+8, radius, itemSize-8, radius);
        path.lineTo(itemSize-8, 32);
        path.close();   

        LinearGradient grad = LinearGradient
        (
            colors: <Color>
            [
                Colors.brown,
                _getOrderColor(orderNo),
            ],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft
        );

        paint.shader = grad.createShader(Rect.fromLTWH(itemSize-40, 0, 32, 32));

        canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) 
    {
        return oldDelegate != this;
    }

    Color _getOrderColor(int orderNo)
    {
        final List<Color> retColor = [Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.cyan];

        if(orderNo > retColor.length)
        {
            return Colors.black;
        }

        return retColor[orderNo];
    }
}