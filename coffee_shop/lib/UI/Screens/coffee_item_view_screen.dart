import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_toast.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/favourite_star.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_chooser.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/temperature_chooser.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class CoffeeItemViewScreen extends StatelessWidget {
  static const String route = '/main/itemview/coffee';
  ShopItem _item;
  AppBar _appBar = AppBar();
  Container _addButton;
  double height = 0;
  String itemID;
  int sugar;
  Temperature temperature;
  String _buttonLabel = LanguageModel.add[LanguageModel.currentLanguage];

  int leavingCounter = 0;

  CoffeeItemViewScreen({this.sugar = 2, this.temperature});

  CoffeeItemViewScreen.withData(this._item);

  @override
  Widget build(BuildContext context) {
    initializeData(context);

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
                      snapshot.connectionState == ConnectionState.waiting) leavingCounter++;

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

  void initializeData(BuildContext context) {
    final Map<String, dynamic> routeArgs = ModalRoute.of(context).settings.arguments;
    itemID = routeArgs['itemID'];
    _item = routeArgs["item"];
    if (_item != null) {
      CoffeeItem coffeeItem = _item as CoffeeItem;
      sugar = coffeeItem.sugar;
    }
    if (routeArgs["buttonLabel"] != null) {
      _buttonLabel = routeArgs["buttonLabel"];
    }
    temperature = Temperature.hot();
  }

  Widget makeItemViewBody(AsyncSnapshot snapshot, BuildContext context) {
    if (_item == null) {
      _item = snapshot.data;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        StrokedText(
          text: _item.name,
          color: Colors.white,
          size: 25,
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
                    border: Border.all(color: Theme.of(context).primaryColor, width: 14),
                    shape: BoxShape.circle,
                    image: new DecorationImage(fit: BoxFit.fill, image: new NetworkImage(_item.imageUrl)))),
            FavouriteStar(itemID: itemID),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: StrokedText(
            text: LanguageModel.sugar[LanguageModel.currentLanguage],
            color: Colors.white,
            size: 25,
          ),
        ),
        SugarChooser(_item, _setSugar),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: StrokedText(
            text: LanguageModel.temperature[LanguageModel.currentLanguage],
            color: Colors.white,
            size: 25,
          ),
        ),
        TemperatureChooser(_item, _setTemperature),
        _addButton,
      ]),
    );
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
            var coffeeItem = CoffeeItem(shopItem: _item, temperature: temperature, sugar: sugar);
            CartItemDB.modifyOrAddItemToCart(coffeeItem, _buttonLabel);
            RenaoToast.itemAdded(_item.name, _buttonLabel);
            Navigator.of(context).pop();
          },
          child: Text(
            _buttonLabel,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _setSugar(int _sugar) {
    this.sugar = _sugar;
  }

  void _setTemperature(Temperature _temperature) {
    this.temperature = _temperature;
  }
}
