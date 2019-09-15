import 'package:flutter/foundation.dart';

class ShopItem
{
    final int id;
    final String name;
    final int price;
    final String imagePath;

    ShopItem({@required this.id, @required this.name, @required this.price, @required this.imagePath});
}