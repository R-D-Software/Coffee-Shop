import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/dummy_data.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_waiting_ring.dart';
import 'package:flutter/material.dart';

import 'cart.dart';
import 'item_slider.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

<<<<<<< HEAD
class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection("shop_items").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return RenaoWaitingRing(); //Penis Ring
          } else {
            return makeHomeBody(snapshot);
          }
        });
  }

  void favouriteIconClick() {
    Navigator.of(context).pushNamed("/main/favourites");
  }

  Widget makeHomeBody(AsyncSnapshot snapshot) {
    List<ShopItem> coffeeItems = new List<ShopItem>();
    List<ShopItem> sandwichItems = new List<ShopItem>();
    List<ShopItem> dealItems = new List<ShopItem>();

    for (DocumentSnapshot ds in snapshot.data.documents) {
      ShopItem currentItem = ShopItem.fromDocument(ds, ds.documentID);
=======
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
>>>>>>> origin/Develop

      switch (currentItem.itemType) {
        case "Coffee":
          coffeeItems.add(currentItem);
          break;

        case "Breakfast":
          sandwichItems.add(currentItem);
          break;
      }

      if (currentItem.onSale) {
        dealItems.add(currentItem);
      }
    }

    return ListView(
      children: <Widget>[
        Cart(DummyData.empty),
        ItemSlider(
            name: LanguageModel.favourites[LanguageModel.currentLanguage],
            icon: Icons.star,
            items: DummyData.items,
            onIconClick: favouriteIconClick),
        ItemSlider(
            name: LanguageModel.coffee[LanguageModel.currentLanguage],
            items: coffeeItems),
        ItemSlider(
            name: LanguageModel.sandwich[LanguageModel.currentLanguage],
            items: sandwichItems),
        ItemSlider(
            name: LanguageModel.todaysDeals[LanguageModel.currentLanguage],
            items: dealItems),
      ],
    );
  }
}
