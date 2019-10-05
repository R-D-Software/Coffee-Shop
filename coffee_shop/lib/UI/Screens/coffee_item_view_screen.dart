import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/favourite_star.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_chooser.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/temperature_chooser.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class CoffeeItemViewScreen extends StatelessWidget {
  ShopItem _item;
  AppBar _appBar = AppBar();
  Container _addButton;
  double height = 0;
  String itemID;
  int sugar;
  Temperature temperature = Temperature.hot();

  int leavingCounter = 0;

  CoffeeItemViewScreen({this.sugar = 2, this.temperature}) {}

  @override
  Widget build(BuildContext context) {
    final Map<String, String> routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    itemID = routeArgs["itemID"];

    if (itemID == null) {
      return Container();
    }

    MediaQueryData mData = MediaQuery.of(context);

    if (mData.orientation == Orientation.portrait) {
      height = mData.size.height;
    } else {
      height = mData.size.width;
    }

    _addButton = _getAddButton(context);

    return Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: RenaoBoxDecoration.builder(context),
            height: height - _appBar.preferredSize.height,
            child: StreamBuilder(
                stream: ShopItemDB.getShopItemByID(itemID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.waiting)
                    leavingCounter++;

                  if (leavingCounter == 2) {
                    return makeItemViewBody(snapshot, context);
                  } else {
                    return Container();
                  }
                }),
            width: double.infinity,
          ),
        ));
  }

  Widget makeItemViewBody(AsyncSnapshot snapshot, BuildContext context) {
    _item = snapshot.data;

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.keyboard_arrow_left),
              StrokedText(
                text: _item.name,
                color: Colors.white,
                size: 25,
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 25),
                  width: height * 0.35,
                  height: height * 0.35,
                  decoration: new BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.red,
                          spreadRadius: 2,
                          offset: new Offset(-5.0, 10.0),
                        )
                      ],
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 14),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(_item.imageUrl)))),
              FavouriteStar(itemID: itemID),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 0),
            child: StrokedText(
              text: "Sugar",
              color: Colors.white,
              size: 25,
            ),
          ),
          SugarChooser(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: StrokedText(
              text: "Temperature",
              color: Colors.white,
              size: 25,
            ),
          ),
          TemperatureChooser(),
          _addButton,
        ]);
  }

  Container _getAddButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ButtonTheme(
        buttonColor: Color.fromRGBO(231, 82, 100, 1),
        minWidth: MediaQuery.of(context).size.width - 20,
        height: height * 0.065,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          elevation: 5,
          onPressed: () {
            var coffeeItem = CoffeeItem(
                shopItem: _item, temperature: Temperature.hot(), sugar: 2);
            CartItemDB.addItemToCart(coffeeItem);
          },
          child: Text(
            "ADD",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
