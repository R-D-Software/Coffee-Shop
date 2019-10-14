import 'package:coffee_shop/Models/language.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RenaoToast {
  RenaoToast.itemAdded(String itemName, String _buttonLabel) {
    if (_buttonLabel == LanguageModel.add[LanguageModel.currentLanguage]) {
      Fluttertoast.showToast(
          msg: itemName + LanguageModel.toastAddToCart[LanguageModel.currentLanguage],
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIos: 1,
          backgroundColor: Color.fromRGBO(231, 82, 100, 1),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
