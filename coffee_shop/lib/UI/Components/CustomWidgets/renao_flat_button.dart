import 'package:flutter/material.dart';

class RenaoFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  double padding;

  RenaoFlatButton(
      {
      @required this.title,
      @required this.textColor,
      @required this.fontSize,
      @required this.fontWeight,
      @required this.onPressed,
      @required this.color,
      @required this.splashColor,
      @required this.borderColor,
      @required this.borderWidth,
      this.padding = 12.0});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: color,
      splashColor: splashColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: this.padding),
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "OpenSans",
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  }
}
