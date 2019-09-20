import 'package:flutter/material.dart';

class CircleCardPicture extends StatelessWidget {
  final double radius;
  final String imagePath;

  CircleCardPicture({@required this.radius, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius / 2),
      ),
      elevation: 2,
      child: Container(
          width: radius,
          height: radius,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(radius / 2),
            image:
                DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
          )),
    );
  }
}
