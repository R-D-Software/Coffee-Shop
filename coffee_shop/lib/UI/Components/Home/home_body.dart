import 'package:flutter/material.dart';

import 'cart.dart';
import 'item_slider.dart';

class HomeScreenBody extends StatefulWidget {
  HomeScreenBody({Key key}) : super(key: key);

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Cart(),
        ItemSlider("Coffee"),
        ItemSlider("Breakfast"),
        ItemSlider("Today's Deals"),
        ItemSlider("Coffee Again"),
      ],
    );
  }
}