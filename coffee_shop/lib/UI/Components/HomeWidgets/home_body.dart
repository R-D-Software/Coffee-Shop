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
            ItemSlider(name: LanguageModel.favourites[LanguageModel.currentLanguage], icon: Icons.star, items: DummyData.shopItems, onIconClick: favouriteIconClick),
            ItemSlider(name: "Coffee", items: DummyData.shopItems),
            ItemSlider(name: "Breakfast", items: DummyData.shopItems),
            ItemSlider(name: "Today's Deals", items: DummyData.shopItems),
            ItemSlider(name: "Coffee Again", items: DummyData.shopItems),
        ],
        );
    }

    void favouriteIconClick()
    {
        Navigator.of(context).pushNamed("/main/favourites");
    }
}