import 'package:flutter/material.dart';

class CartItemCounter extends StatelessWidget {
  final int cartItemsNumber;
  final double top;
  final double right;

  CartItemCounter.smallerThan10(this.cartItemsNumber, {this.top = 3.5, this.right = 4.5});
  CartItemCounter.biggerThan10(this.cartItemsNumber, {this.top = 3.5, this.right = 2});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10,
        left: 10,
        child: Stack(
          children: <Widget>[
            Icon(Icons.brightness_1, size: 15.0, color: Colors.red[700]),
            Positioned(
                top: top,
                right: right,
                child: Center(
                  child: Text(
                    "$cartItemsNumber",
                    style: TextStyle(color: Colors.white, fontSize: 8.0, fontWeight: FontWeight.w500),
                  ),
                )),
          ],
        ));
  }
}
