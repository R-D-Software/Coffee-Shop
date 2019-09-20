import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Screens/cart_screen.dart';
import 'package:coffee_shop/UI/Screens/home_screen.dart';
import 'package:coffee_shop/UI/Screens/quest_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  HomeScreen homeScreen = HomeScreen();
  QuestScreen questScreen = QuestScreen();
  CartScreen cartScreen = CartScreen();
  List<Widget> pages;

  Widget currentPage;

  @override
  void initState() {
    super.initState();
    pages = [homeScreen, questScreen, cartScreen];
    currentPage = homeScreen;
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
                color: Colors.white,
              ),
            Positioned(
              bottom: 10,
                left: 10,
                child: Stack(
              children: <Widget>[
                Icon(Icons.brightness_1,
                    size: 15.0, color: Colors.red[700]),
                Positioned(
                    top: 3.5,
                    right: 3,
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.0,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
              ],
            )),
          ],
        ),
      ),
    ];
  }
}
