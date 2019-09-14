import 'package:coffee_shop/UI/Screens/home_screen.dart';
import 'package:coffee_shop/UI/Screens/quest_screen.dart';
import 'package:coffee_shop/UI/Screens/wallet_screen.dart';
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
  //WalletScreen walletScreen = WalletScreen();
  List<Widget> pages;

  Widget currentPage;

  @override
  void initState() {
    super.initState();
    pages = [homeScreen, questScreen];
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
        title: new Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.loyalty),
        title: new Text('Quest'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text('Cart'),
      ),
    ];
  }
}
