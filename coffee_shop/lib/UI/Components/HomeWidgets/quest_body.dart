import 'dart:ui';

import 'package:coffee_shop/Models/quest.dart';
import 'package:flutter/material.dart';

import '../stroked_text.dart';

class QuestBody extends StatelessWidget 
{
  double imageHeight = 250;
  Quest quest = Quest(4, 3, 'assets/images/quest_coffee.png');
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomPaint(
          child: Container(
              color: Colors.transparent,
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      child:
                          StrokedText(text: "Coffee of the week", size: 25))),
              height: 50),
          painter: CurvePainter(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
              child: StrokedText(text: "Order ${quest.missingParts} more lattes to get a free one!", capsOn: true)),
        ),
        Stack(
          children: <Widget>[
            Container(
              height: widget.imageHeight,
              child: Image.asset(
                quest.imgPath,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              height: widget.imageHeight/(quest.numberOfPiecies/quest.missingParts),
              child: Container(
                color: Theme.of(context).accentColor,
              )
            ),
          ],
        ),
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  final BuildContext context;

  CurvePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    MediaQueryData mQueryData = MediaQuery.of(context);

    double width = mQueryData.size.width;

    List<Offset> polygon = <Offset>[
      new Offset(40, 0),
      new Offset(40, 25),
      new Offset(70, 50),
      new Offset(width - 70, 50),
      new Offset(width - 40, 25),
      new Offset(width - 40, 0)
    ];

    path.addPolygon(polygon, true);
    path.close();

    LinearGradient grad = LinearGradient(colors: <Color>[
      Theme.of(context).primaryColor.withOpacity(1),
      Colors.brown,
      Theme.of(context).primaryColor.withOpacity(1),
    ], end: Alignment.bottomRight, begin: Alignment.topLeft);

    paint.shader = grad.createShader(Rect.fromLTWH(0, 0, width, 60));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
