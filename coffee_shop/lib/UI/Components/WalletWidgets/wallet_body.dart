import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Business/MapNavigator/google_navigator.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/depositDialog.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/WalletWidgets/purchase_history_component.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:coffee_shop/UI/Screens/place_changer_screen.dart';
import 'package:flutter/material.dart';

class WalletBody extends StatefulWidget {
  final double appBarHeight;

  WalletBody({@required this.appBarHeight});

  @override
  _WalletBodyState createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  Widget shopImage;
  Container balance;
  Container button;
  double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height -
        new AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return StreamBuilder(
      stream: UserDB.getCurrentUserSelectedShop().asStream(),
      builder: (context, shopSnap) {
        if (shopSnap.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return StreamBuilder(
            stream: UserDB.getCurrentUserBalance().asStream(),
            builder: (context, balanceSnap) {
              if (balanceSnap.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return _buildBody(context, (shopSnap.data as Shop),
                    (balanceSnap.data as int));
              }
            },
          );
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, Shop currentShop, int ubalance) {
    shopImage = _getPlaceWidget(context, currentShop);
    balance = _balanceBuilder(context, ubalance);
    button = _buttonBuilder(context);

    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              shopImage,
              SizedBox(
                height: height * 0.01,
              ),
              balance,
              Container(
                child: StrokedText(
                    text: LanguageModel
                        .purchaseHistory[LanguageModel.currentLanguage],
                    size: height * 0.09 * 0.35),
                margin: EdgeInsets.only(
                    bottom: height * 0.001, top: height * 0.001),
              ),
              PurchaseHistoryComponent(height: height * 0.3),
            ],
          ),
          button,
        ],
      ),
    );
  }

  Widget _buttonBuilder(BuildContext context) {
    return Container(
        width: double.infinity,
        height: height * 0.091,
        margin: EdgeInsets.only(bottom: height * 0.01),
        child: RenaoFlatButton(
          padding: height * 0.09 * 0.01,
          title: LanguageModel.deposit[LanguageModel.currentLanguage],
          fontSize: height * 0.09 * 0.4,
          fontWeight: FontWeight.w700,
          textColor: Colors.white,
          onPressed: () {
            DepositDialog.showDialog(
                context: context,
                title: LanguageModel.deposit[LanguageModel.currentLanguage]);
          },
          splashColor: Colors.black12,
          borderColor: Colors.white,
          borderWidth: 2,
          color: Colors.red[300],
        ));
  }

  Widget _getPlaceWidget(BuildContext context, Shop currentShop) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(PlaceChangerScreen.route);
        setState(() {});
      },
      child: Container(
        height: height * 0.44,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(height * 0.44 * 0.15))),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(height * 0.44 * 0.15),
                child: Image.network(
                  currentShop.imageURL,
                  height: height * 0.44,
                  width: height * 0.44,
                ),
              ),
              _buildPlaceHeader(context, currentShop),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceHeader(BuildContext context, Shop currentShop) {
    return GestureDetector(
        onTap: () {
          GoogleNavigator.navigate(currentShop.latitude, currentShop.longitude);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height * 0.44 * 0.15),
                  topRight: Radius.circular(height * 0.44 * 0.15)),
              color: Colors.grey.withOpacity(0.8),
            ),
            height: height * 0.44 * 0.15,
            width: height * 0.44,
            alignment: Alignment.center,
            child: SizedBox(
              width: height * 0.44 * 0.92,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: AutoSizeText(
                      currentShop.toString().toUpperCase(),
                      style: TextStyle(color: Colors.white),
                      maxFontSize: 20,
                      minFontSize: 10,
                      maxLines: 1,
                    ),
                  ),
                  Icon(
                    Icons.navigation,
                    color: Colors.blue,
                    size: height * 0.05,
                  ),
                ],
              ),
            )));
  }

  Widget _balanceBuilder(BuildContext context, int balance) {
    if (balance == null) {
      balance = 0;
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: StrokedText(
                    text: LanguageModel
                        .yourBalance[LanguageModel.currentLanguage],
                    size: height * 0.09 * 0.5,
                  ),
                ),
                StrokedText(
                    text: balance.toString() + " HUF",
                    color: Color.fromRGBO(229, 138, 237, 1),
                    size: height * 0.09 * 0.5)
              ],
            )));
  }
}
