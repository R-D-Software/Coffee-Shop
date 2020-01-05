import 'package:flutter/material.dart';

class SugarCard extends StatelessWidget {
  double width;
  double height;
  String imagePath;

  SugarCard({@required this.width, @required this.height, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card
      (
      elevation: 2,
      child: Container
        (
        child: Image.asset(imagePath),
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
