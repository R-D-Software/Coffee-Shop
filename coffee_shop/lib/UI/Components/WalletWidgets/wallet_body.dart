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

  @override
  Widget build(BuildContext context) {
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
                return _buildBody(context, (shopSnap.data as Shop), (balanceSnap.data as int));
              }
            },
          );
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, Shop currentShop, int ubalance) {
    double deviceHeight = MediaQuery.of(context).size.height;
    shopImage = _getPlaceWidget(context, currentShop);
    balance = _balanceBuilder(context, ubalance);
    button = _buttonBuilder(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              shopImage,
              SizedBox(
                height: 20,
              ),
              balance,
              Container(
                child: StrokedText(text: LanguageModel.purchaseHistory[LanguageModel.currentLanguage], size: 20),
                margin: EdgeInsets.all(10),
              ),
              PurchaseHistoryComponent(
                  height: deviceHeight -
                      widget.appBarHeight -
                      MediaQuery.of(context).size.width * 0.80 /*ShopImageHeight*/
                      -
                      20 /*SizedBox*/
                      -
                      30 /*BalanceHeight*/
                      -
                      34 /*purchase history text height*/
                      -
                      52 /*AdditionalHeight because of default spaces between widgets*/
                      -
                      (65 - 15) /*ButtonHeight*/
                  ),
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
        height: 65,
        margin: EdgeInsets.only(bottom: 15),
        child: RenaoFlatButton(
          title: LanguageModel.deposit[LanguageModel.currentLanguage],
          fontSize: 30,
          fontWeight: FontWeight.w700,
          textColor: Colors.white,
          onPressed: () {
            DepositDialog.showDialog(context: context, title: LanguageModel.deposit[LanguageModel.currentLanguage]);
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
        height: MediaQuery.of(context).size.width * 0.80,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(40.0),
                child: Image.network(
                  currentShop.imageURL,
                  height: MediaQuery.of(context).size.width * 0.80,
                  width: MediaQuery.of(context).size.width * 0.80,
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
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.grey.withOpacity(0.8),
          ),
          height: 40,
          width: MediaQuery.of(context).size.width * 0.80,
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
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
                ),
              ],
            ),
          )),
    );
  }

  Widget _shopImageBuilder(BuildContext context) {
    return Container(
        height: 270,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            'assets/images/kav.jpg',
            fit: BoxFit.cover,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ));
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
                    text: LanguageModel.yourBalance[LanguageModel.currentLanguage],
                    size: 28,
                  ),
                ),
                StrokedText(text: balance.toString() + " HUF", color: Color.fromRGBO(229, 138, 237, 1), size: 28)
              ],
            )));
  }

  Widget _navigationWidgetBuilder(BuildContext context) {
    return Container(
      height: 25,
      child: GestureDetector(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              LanguageModel.navigatoToShop[LanguageModel.currentLanguage],
              style: TextStyle(color: Colors.cyan),
            )),
        onTap: () {
          print("NAVIGÁNI AKAR A GYEREK");
        },
      ),
    );
  }
}
