import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Exceptions/RenaoException.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/material.dart';

class CoffeeItem extends ShopItem {
  Temperature temperature;
  int sugar;

  CoffeeItem({@required ShopItem shopItem, @required this.temperature, @required this.sugar})
      : super(
            documentID: shopItem.documentID,
            imageUrl: shopItem.imageUrl,
            name: shopItem.name,
            price: shopItem.price,
            description: shopItem.description,
            itemType: "coffee",
            onSale: shopItem.onSale);

  Map<String, Object> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'itemType': itemType,
      'onSale': onSale,
      'appIdentifier': 'Renao',
      'temperature': temperature.temperature,
      'sugar': sugar
    };
  }

  factory CoffeeItem.fromJson(Map<String, Object> doc, String documentID) {
    if (doc['sugar'] == null || doc['temperature'] == null) {
      throw RenaoException.notCoffeeItemException();
    }
    CoffeeItem item = CoffeeItem(
      shopItem: ShopItem(
        documentID: documentID,
        name: doc['name'],
        price: doc['price'],
        imageUrl: doc['imageUrl'],
        description: doc['description'],
        onSale: doc['onSale'],
        itemType: doc['itemType'],
      ),
      temperature: _setTemperature(doc['temperature']),
      sugar: doc['sugar'],
    );
    return item;
  }

  factory CoffeeItem.fromDocument(DocumentSnapshot doc, String documentID) {
    return CoffeeItem.fromJson(doc.data, documentID);
  }
}

Temperature _setTemperature(String temperature) {
  if (temperature == LanguageModel.hot[Language.ENGLISH] || temperature == LanguageModel.hot[Language.HUNGARIAN])
    return Temperature.hot();
  else if (temperature == LanguageModel.warm[Language.ENGLISH] || temperature == LanguageModel.warm[Language.HUNGARIAN])
    return Temperature.warm();
  else if (temperature == LanguageModel.cold[Language.ENGLISH] || temperature == LanguageModel.cold[Language.HUNGARIAN])
    return Temperature.cold();
  else
    return Temperature.iceCold();
}

class Temperature {
  String temperature;
  Color color;

  Temperature.iceCold() {
    temperature = LanguageModel.iceCold[LanguageModel.currentLanguage];
    color = Colors.lightBlueAccent;
  }

  Temperature.cold() {
    temperature = LanguageModel.cold[LanguageModel.currentLanguage];
    color = Colors.blueAccent;
  }

  Temperature.warm() {
    temperature = LanguageModel.warm[LanguageModel.currentLanguage];
    color = Colors.redAccent;
  }

  Temperature.hot() {
    temperature = LanguageModel.hot[LanguageModel.currentLanguage];
    color = Colors.red;
  }
}
