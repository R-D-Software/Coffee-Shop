import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Models/food_item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_dialog.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_toast.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/favourite_star.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class FoodItemViewScreen extends StatelessWidget {
  ShopItem _item;
  AppBar _appBar = AppBar();
  Container _addButton;
  double height = 0;
  String itemID;
  String _buttonLabel = LanguageModel.add[LanguageModel.currentLanguage];

  int leavingCounter = 0;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> routeArgs = ModalRoute.of(context).settings.arguments;
    initializeData(routeArgs);

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

  void initializeData(Map<String, dynamic> routeArgs) {
    itemID = routeArgs['itemID'];
    _item = routeArgs["item"];
    if (routeArgs["buttonLabel"] != null) {
      _buttonLabel = routeArgs["buttonLabel"];
    }
  }

  Widget makeItemViewBody(AsyncSnapshot snapshot, BuildContext context) {
    if (_item == null) {
      _item = snapshot.data;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.35),
                child: _buildInformationIcon(context),
              ),
            ),
          ],
        ),
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
            var foodItem = FoodItem(shopItem: _item);
            CartItemDB.modifyOrAddItemToCart(foodItem, _buttonLabel);
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

  Container _buildInformationIcon(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        onPressed: () {
          RenaoDialog.showDialog(context: context, title: _item.name, description: _item.description);
        },
        child: Icon(
          Icons.info,
          color: Colors.blue,
          size: 40.0,
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
      ),
    );
  }
}
