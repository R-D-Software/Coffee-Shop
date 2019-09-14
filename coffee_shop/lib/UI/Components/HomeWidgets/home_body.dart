import 'package:coffee_shop/Models/dummy_data.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

import 'cart.dart';
import 'item_slider.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> 
{
    @override
    Widget build(BuildContext context) {

        return ListView(
        children: <Widget>
        [
            Cart(DummyData.empty),
            ItemSlider(name: LanguageModel.favourites[LanguageModel.currentLanguage], icon: Icons.star, items: DummyData.items, onIconClick: favouriteIconClick),
            ItemSlider(name: "Coffee", items: DummyData.items),
            ItemSlider(name: "Breakfast", items: DummyData.items),
            ItemSlider(name: "Today's Deals", items: DummyData.items),
            ItemSlider(name: "Coffee Again", items: DummyData.items),
        ],
        );
    }

    void favouriteIconClick()
    {
        Navigator.of(context).pushNamed("/main/favourites");
    }
}