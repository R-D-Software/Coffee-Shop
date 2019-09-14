import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/WalletComponents/balance_component.dart';
import 'package:flutter/material.dart';

class WalletBody extends StatelessWidget 
{
    @override
    Widget build(BuildContext context)
    {
        BalanceComponent bc = BalanceComponent();
        return Container
        (
            child: Column
            (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                    Container
                    (
                        margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height/2) - (bc.height)*2),
                        child: bc,  
                    ),

                    Container
                    (
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton
                        (
                            color: Colors.red,
                            child: Text(LanguageModel.add[LanguageModel.currentLanguage]), onPressed: () {},
                        ),
                    ),
                ],
            ),
        );
    }

}
