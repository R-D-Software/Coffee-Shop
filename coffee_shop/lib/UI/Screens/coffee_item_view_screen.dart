import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/quest_DB.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/quest.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_dialog.dart';
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
  Quest quest;
  double sideFontSize;
  final double maxFontSize = 27;
  final double maxIconSize = 37;

  int leavingCounter = 0;

  CoffeeItemViewScreen({this.sugar = 2, this.temperature});

  CoffeeItemViewScreen.withData(this._item);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mData = MediaQuery.of(context);
    height = mData.size.height - _appBar.preferredSize.height - mData.padding.top;
    initializeData(context);

    _addButton = _getAddButton(context);
    
    return Scaffold(
        appBar: _appBar,
        body: Container(
            height: height,
            decoration: RenaoBoxDecoration.builder(context),          
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
        );
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
    if (routeArgs["quest"] != null) {
      quest = routeArgs["quest"];
    }
    
    temperature = Temperature.hot();
    sideFontSize = (height*0.04 > maxFontSize*0.9 ? maxFontSize*0.9 : height*0.04);
  }

  Widget makeItemViewBody(AsyncSnapshot snapshot, BuildContext context) {
    if (_item == null) {
      _item = snapshot.data;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        StrokedText(
            text: _item.name,
            color: Colors.white,
            size: (height*0.04 > maxFontSize ? maxFontSize : height*0.04),
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
                width: height * 0.35,
                height: height * 0.35,
                decoration: new BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.red,
                        spreadRadius: 2,
                        offset: new Offset(-(5.0), 10.0),
                      )
                    ],
                    border: Border.all(color: Theme.of(context).primaryColor, width: (height * 0.35*0.07)),
                    shape: BoxShape.circle,
                    image: new DecorationImage(fit: BoxFit.fill, image: new NetworkImage(_item.imageUrl)))),
            FavouriteStar(itemID: itemID),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.32),
                child: _buildInformationIcon(context),
              ),
            ),
          ],
        ),
        SizedBox(height: height* 0.05,),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: StrokedText(
            text: LanguageModel.sugar[LanguageModel.currentLanguage],
            color: Colors.white,
            size: sideFontSize,
          ),
        ),
        SugarChooser(_item, _setSugar, height * 0.1),
        SizedBox(height: height * 0.03,),
        StrokedText(
            text: LanguageModel.temperature[LanguageModel.currentLanguage],
            color: Colors.white,
            size: sideFontSize,
        ),
        SizedBox(height: height * 0.005,),
        TemperatureChooser(_item, _setTemperature, height * 0.01),
        SizedBox(height: height * 0.01,),
        _addButton,
        SizedBox(height: 0,)
      ]),
    );
  }

  Container _buildInformationIcon(BuildContext context) {
    return Container(
        height: (height * 0.06 > maxIconSize ? maxIconSize : height * 0.06),
      child: RawMaterialButton(
        onPressed: () {
          RenaoDialog.showDialog(context: context, title: _item.name, description: _item.description);
        },
        child: Icon(
          Icons.info,
          color: Colors.blue,
          size: (height * 0.06 > maxIconSize ? maxIconSize : height * 0.06),
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
      ),
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

            if(quest != null)
            {
                QuestDB.setQuestStatus(StaticData.currentUser.userID, QuestStatus.ITEM_ADDED_TO_CART, quest.calendarWeek);
            }

            Navigator.of(context).pop();
          },
          child: Text(
            _buttonLabel,
            style: TextStyle(fontSize: height*0.045, color: Colors.white),
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
