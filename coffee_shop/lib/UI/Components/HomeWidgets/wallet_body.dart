import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/WalletComponents/purchase_history_component.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class WalletBody extends StatelessWidget 
{  
    Container shopImage;
    Container balance;
    Container button;
    final double appBarHeight;

    WalletBody({@required this.appBarHeight});

    @override
    Widget build(BuildContext context)
    {
        double deviceHeight = MediaQuery.of(context).size.height;
        shopImage = _shopImageBuilder(context);
        balance = _balanceBuilder(context);
        button = _buttonBuilder(context);

        return Container
        (
            child: Column
            (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                    Column
                    (
                        children: <Widget>
                        [
                                shopImage,
                                _navigationWidgetBuilder(context),
                                SizedBox(height: 20,),
                                balance,
								Container
								(
									child: StrokedText(text: LanguageModel.purchaseHistory[LanguageModel.currentLanguage], size: 20),
									margin: EdgeInsets.all(10),
								),
                                PurchaseHistoryComponent
                                (
                                    height: deviceHeight 
                                    - appBarHeight 
                                    - 270 /*ShopImageHeight*/ 
                                    - 25  /*NavigationHeight*/
                                    - 20  /*SizedBox*/ 
                                    - 30  /*BalanceHeight*/ 
									- 34  /*purchase history text height*/
                                    - 42  /*AdditionalHeight because of default spaces between widgets*/ 
                                    - (65 - 15) /*ButtonHeight*/
                                ),
                        ],
                    ),
                    button,
                ],
            ),
        );
    }

    Widget _buttonBuilder(BuildContext context)
    {
        return Container
        (
            width: double.infinity,
            height: 65,
            margin: EdgeInsets.only(bottom: 15),
            child: RenaoFlatButton
            (
                title: LanguageModel.deposit[LanguageModel.currentLanguage],
                fontSize: 30,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
                onPressed: () 
                {

                },
                splashColor: Colors.black12,
                borderColor: Colors.white,
                borderWidth: 2,
                color: Colors.red[300],
            )
        );
    }

    Widget _shopImageBuilder(BuildContext context)
    {
        return Container
        (
            height: 270,
            child: Card
            (
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset
                (
                    'assets/images/kav.jpg',
                    fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder
                (
                    borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
            )
        );
    }  

    Widget _balanceBuilder(BuildContext context)
    {
        return Container
        (
            width: MediaQuery.of(context).size.width,
            child: Align
            (
                alignment: Alignment.center,
                child: Row
                (
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>
                    [
                        FittedBox
                        (
                            fit:BoxFit.fitWidth, 
                            child: StrokedText
                            (
                                text: LanguageModel.yourBalance[LanguageModel.currentLanguage],
                                size: 28,
                            ),
                        ),  
                        
                        StrokedText
                        (
                            text: "500 HUF",
                            color: Color.fromRGBO(229, 138, 237,1),
                            size: 28
                        )
                    ],
                )
            )
        );
    }

    Widget _navigationWidgetBuilder(BuildContext context)
    {
        return Container
        (
            height: 25,
            child: GestureDetector
            (
                child: Align
                (
                    alignment: Alignment.center,
                    child: Text
                    (
                        LanguageModel.navigatoToShop[LanguageModel.currentLanguage],
                        style: TextStyle
                        (
                            color: Colors.cyan
                        ),
                    )
                ),
                onTap: ()
                {
                    print("NAVIGÁNI AKAR A GYEREK");
                },
            ),
        );
    }
}