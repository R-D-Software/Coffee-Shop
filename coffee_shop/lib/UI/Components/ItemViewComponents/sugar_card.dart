import 'package:flutter/material.dart';

class SugarCard extends StatelessWidget {
  double width;
  double height;

  SugarCard({@required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Card
      (
      elevation: 2,
      child: Container
        (
        child: Image.asset("assets/images/sugar.png"),
        width: width,
        height: height,
        decoration: BoxDecoration
          (
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6.0))
        ),
      ),
    );
  }
}
