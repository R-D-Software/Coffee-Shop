import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/dummy_data.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:flutter/material.dart';

import 'cart_on_homescreen.dart';
import 'item_slider.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection("shop_items").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); //Penis Ring
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

    return buildItemSliders(coffeeItems, sandwichItems, dealItems);
  }

  Widget buildItemSliders(List<ShopItem> coffeeItems,
      List<ShopItem> sandwichItems, List<ShopItem> dealItems) 
      {
    return StreamBuilder(
        stream: UserDB.getCurrentUser().asStream(),
        builder: (context, snapshot) 
        {
          if (snapshot.connectionState == ConnectionState.waiting) 
          {
            return Container();
          }

          User user = snapshot.data as User;

          return StreamBuilder(
              stream: ShopItemDB.getShopItems(),
              builder: (context1, snapshot1) 
              {
                QuerySnapshot items = snapshot1.data as QuerySnapshot;
                List<ShopItem> favouriteItems = new List<ShopItem>();

                if (items == null && user.favouriteItems != null) return Container();

                for (String itemID in user.favouriteItems) 
                {
                  for (DocumentSnapshot doc in items.documents) 
                  {
                    if (itemID == doc.documentID) 
                    {
                      favouriteItems
                          .add(ShopItem.fromDocument(doc, doc.documentID));
                    }
                  }
                }
                return ListView(
                  children: <Widget>[
                    //CartOnHomeScreen(DummyData.empty),
                    ItemSlider(
                        name: LanguageModel
                            .favourites[LanguageModel.currentLanguage],
                        icon: Icons.star,
                        items: favouriteItems,
                        onIconClick: favouriteIconClick),
                    ItemSlider(
                        name:
                            LanguageModel.coffee[LanguageModel.currentLanguage],
                        items: coffeeItems),
                    ItemSlider(
                        name: LanguageModel
                            .sandwich[LanguageModel.currentLanguage],
                        items: sandwichItems),
                    ItemSlider(
                        name: LanguageModel
                            .todaysDeals[LanguageModel.currentLanguage],
                        items: dealItems),
                  ],
                );
              });
        });
  }
}
