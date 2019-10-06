import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/ItemViewComponents/sugar_card.dart';
import 'package:flutter/material.dart';

import '../stroked_text.dart';

class SugarChooser extends StatefulWidget {
  ShopItem _item;
  int sugar;
  final int _maxSugar = 4;
  final int _minSugar = 0;
  Function setSugarValueOnParentScreen;

  SugarChooser(this._item, this.setSugarValueOnParentScreen);

  @override
  _SugarChooserState createState() => _SugarChooserState();
}

class _SugarChooserState extends State<SugarChooser> {
  List<Widget> sugars = [];

  @override
  Widget build(BuildContext context) {
    int i = 0;
    sugars.clear();
    while (i < widget.sugar) {
      sugars.add(SugarCube());
      i++;
    }
    return Container(
      width: double.infinity,
      height: 75,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Container(
            child: IconButton(
              icon: Icon(Icons.remove),
              iconSize: 30,
              onPressed: () {
                modifySugar("-");
              },
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 100,
          child: sugars.isEmpty ? _getNoSugarText() : _getSugars(),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () {
              modifySugar("+");
            },
          ),
        ),
      ]),
    );
  }

  void modifySugar(String operation) {
    if (operation == "+") {
      if (widget.sugar < widget._maxSugar) widget.sugar++;
      setState(() {});
    } else if (operation == "-") {
      if (widget.sugar > widget._minSugar) widget.sugar--;
      setState(() {});
    }
    widget.setSugarValueOnParentScreen(widget.sugar);
  }

  Widget SugarCube() {
    return SugarCard(
      height: 50,
      width: 50,
    );
  }

  @override
  void initState() {
    if (widget._item is CoffeeItem) {
      CoffeeItem coffeeItem = widget._item as CoffeeItem;
      widget.sugar = coffeeItem.sugar;
    } else {
      widget.sugar = 2;
    }
  }

  Widget _getNoSugarText() {
    return StrokedText(
      text: LanguageModel.withoutSugar[LanguageModel.currentLanguage],
      size: 20,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _getSugars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[...sugars],
    );
  }
}
