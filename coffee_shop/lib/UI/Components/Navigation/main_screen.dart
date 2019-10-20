import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Cart/decide_item_type.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/cart_item_counter.dart';
import 'package:coffee_shop/UI/Screens/cart_screen.dart';
import 'package:coffee_shop/UI/Screens/home_screen.dart';
import 'package:coffee_shop/UI/Screens/quest_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  static const String route = '/main';
  @override
  MainScreenState createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static int currentTab = 0;
  HomeScreen homeScreen = HomeScreen();
  QuestScreen questScreen = QuestScreen();
  CartScreen cartScreen = CartScreen();
  List<Widget> pages;
  String userID;

  Widget currentPage;

  @override
  void initState() {
    super.initState();
    pages = [homeScreen, questScreen, cartScreen];
    currentPage = pages[currentTab];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final BottomNavigationBar navBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      elevation: 4,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Theme.of(context).accentColor,
      onTap: (int numTab) {
        setState(() {
          currentTab = numTab;
          currentPage = pages[numTab];
        });
      },
      items: bottomNavBarItems(),
    );

    return Scaffold(
      bottomNavigationBar: navBar,
      body: currentPage,
    );
  }

  List<BottomNavigationBarItem> bottomNavBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: new Icon(Icons.home),
        title: new Text(LanguageModel.home[LanguageModel.currentLanguage]),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.loyalty),
        title: new Text(LanguageModel.quest[LanguageModel.currentLanguage]),
      ),
      BottomNavigationBarItem(
        title: Text(LanguageModel.cart[LanguageModel.currentLanguage]),
        icon: Stack(
          children: <Widget>[
            new Icon(
              Icons.shopping_cart,
            ),
            StreamBuilder(
                stream: UserDB.getCurrentUser().asStream(),
                builder: (context, userSnapshot) {
                  return StreamBuilder(
                      stream: CartItemDB.fetchCartItems(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null)
                          return Container(
                            width: 0,
                            height: 0,
                          );

                        QuerySnapshot shopItems = snapshot.data as QuerySnapshot;
                        List<ShopItem> cartItems = [];

                        for (DocumentSnapshot doc in shopItems.documents) {
                          ShopItem item = DecideItemType.getItemByClassFromFireStore(doc);
                          cartItems.add(item);
                        }

                        return buildCartItemCounter(cartItems);
                      });
                }),
          ],
        ),
      ),
    ];
  }

  Widget buildCartItemCounter(List<ShopItem> cartItems) {
    if (cartItems.isEmpty) {
      return Container(
        width: 0,
        height: 0,
      );
    } else if (cartItems.length < 10) {
      return CartItemCounter.smallerThan10(cartItems.length);
    } else {
      return CartItemCounter.biggerThan10(cartItems.length);
    }
  }
}
