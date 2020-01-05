import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/quest_DB.dart';
import 'package:coffee_shop/Business/string_service.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/circle_card_picture.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_card.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  final ShopItem item;
  final double height = 100;
  final Function refreshFunction;

  CartListItem({@required this.item, @required this.refreshFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.only(bottom: 30, left: 10),
        color: Color.fromRGBO(255, 255, 255, 0),
        elevation: 0,
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed("/main/itemview/${item.itemType}",
              arguments: {"item": item, "buttonLabel": LanguageModel.modify[LanguageModel.currentLanguage]}),
          child: Stack(
            children: <Widget>[
              _getInfoRow(context),
              _buildCirclePicture(),
              _buildIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCirclePicture() {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10),
      child: CircleCardPicture(
        radius: 80,
        imagePath: "assets/images/kav.jpg",
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 10, top: 20),
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await CartItemDB.deleteItemFromCart(item);
          QuestDB.changeQuestStatusIfNeededUpponDelete(item);
          refreshFunction();
        },
        padding: EdgeInsets.all(10),
        iconSize: 40,
      ),
    );
  }

  Widget _getInfoRow(BuildContext context) {
    bool isCoffeeItem = false;
    if (item is CoffeeItem) {
      isCoffeeItem = true;
    }
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: height,
      padding: EdgeInsets.only(left: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 20 - 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildItemHeader(context),
                isCoffeeItem ? _buildItemBody() : Container(),
                isCoffeeItem ? _getIcons(context) : Container(),
                _buildItemFooter(context),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Color.fromRGBO(189, 150, 150, 1),
          borderRadius: BorderRadius.all(Radius.circular(height / 2))),
    );
  }

  StrokedText _buildItemFooter(BuildContext context) {
    return StrokedText(text: "${item.price} Ft", color: Theme.of(context).primaryColor, size: 14);
  }

  StrokedText _buildItemHeader(BuildContext context) {
    return StrokedText(text: "${item.name}", color: Theme.of(context).primaryColor, size: 20);
  }

  StrokedText _buildItemBody() {
    CoffeeItem coffeeItem = item as CoffeeItem;
    return StrokedText(text: coffeeItem.temperature.temperature, color: coffeeItem.temperature.color, size: 16);
  }

  Widget _getIcons(BuildContext context) {
    CoffeeItem coffeeItem = item as CoffeeItem;
    List<Widget> sugarIcons = List();
    for (int i = 0; i < coffeeItem.sugar; i++) {
      sugarIcons.add(SugarCard(
        width: 15,
        height: 15,
        imagePath: StringService.getPathForPic(coffeeItem.sugarType),
      ));
    }
    return sugarIcons.isEmpty
        ? StrokedText(
            text: LanguageModel.withoutSugar[LanguageModel.currentLanguage],
            color: Theme.of(context).primaryColor,
            size: 15)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[...sugarIcons],
          );
  }
}
