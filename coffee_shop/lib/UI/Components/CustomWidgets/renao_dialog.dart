import 'package:coffee_shop/Models/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RenaoDialog {
  RenaoDialog.showDialog(
      {@required BuildContext context,
      @required String title,
      @required String description}) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "$description",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "$title",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  static void showCantOpenDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LanguageModel
                .cannotOpenTheBoxTitle[LanguageModel.currentLanguage]),
            content: Text(LanguageModel
                .cannotOpenTheBoxContent[LanguageModel.currentLanguage]),
          );
        });
  }

  static Future<bool> showOpenDialog(BuildContext context) async {
    return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text(LanguageModel.openTheBox[LanguageModel.currentLanguage]),
            content: Text(
                LanguageModel.areYouSureToOpen[LanguageModel.currentLanguage]),
            actions: <Widget>[
              FlatButton(
                child: Text(LanguageModel.no[LanguageModel.currentLanguage]),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(LanguageModel.yes[LanguageModel.currentLanguage]),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  static void showBoxIsOpen(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LanguageModel
                .boxIsAlreadyOpenedTitle[LanguageModel.currentLanguage]),
            content: Text(LanguageModel
                .boxIsAlreadyOpenedContent[LanguageModel.currentLanguage]),
          );
        });
  }
}
