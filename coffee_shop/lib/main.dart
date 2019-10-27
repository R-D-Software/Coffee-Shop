import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/UI/Components/Navigation/main_screen.dart';
import 'package:coffee_shop/UI/Screens/favourite_list_screen.dart';
import 'package:coffee_shop/UI/Screens/home_screen.dart';
import 'package:coffee_shop/UI/Screens/quest_screen.dart';
import 'package:coffee_shop/UI/Screens/settings.dart';
import 'package:coffee_shop/UI/Screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/Screens/coffee_item_view_screen.dart';
import 'UI/Screens/food_item_view_screen.dart';
import 'UI/Screens/log_in_screen.dart';
import 'UI/Screens/order_page_screen.dart';
import 'UI/Screens/place_changer_screen.dart';
import 'UI/Screens/post_box_screen.dart';
import 'UI/Screens/root_screen.dart';
import 'UI/Screens/sign_up_screen.dart';

void main() {
  //SystemChrome.setEnabledSystemUIOverlays([]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    return MaterialApp(
      title: 'Renao',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("hu", "HU"),
      ],
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        RootScreen.route: (BuildContext context) => RootScreen(),
        LogInScreen.route: (BuildContext context) => LogInScreen(),
        SignUpScreen.route: (BuildContext context) => SignUpScreen(),
        HomeScreen.route: (BuildContext context) => HomeScreen(),
        MainScreen.route: (BuildContext context) => MainScreen(),
        CoffeeItemViewScreen.route: (BuildContext context) => CoffeeItemViewScreen(),
        FoodItemViewScreen.route: (BuildContext context) => FoodItemViewScreen(),
        FavouriteListScreen.route: (BuildContext context) => FavouriteListScreen(),
        WalletScreen.route: (BuildContext context) => WalletScreen(),
        SettingsScreen.route: (BuildContext context) => SettingsScreen(),
        QuestScreen.route: (BuildContext context) => QuestScreen(),
        OrderPageScreen.route: (BuildContext context) => OrderPageScreen(),
        PlaceChangerScreen.route: (BuildContext context) => PlaceChangerScreen(),
        PostBoxScreen.route: (BuildContext context) => PostBoxScreen(),
      },
      theme: ThemeData(
          primaryColor: Color.fromRGBO(76, 53, 47, 1),
          accentColor: Color.fromRGBO(171, 122, 91, 1),
          textTheme: TextTheme(body1: TextStyle(fontFamily: "Roboto", fontSize: 20)),
          iconTheme: IconThemeData(color: Colors.white, opacity: 1, size: 39)),
      home: RootScreen(),
    );
  }
}
