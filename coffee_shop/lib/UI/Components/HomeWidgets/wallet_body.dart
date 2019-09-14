import 'dart:ui';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/WalletComponents/balance_component.dart';
import 'package:coffee_shop/UI/Components/WalletComponents/purchase_history_component.dart';
import 'package:flutter/material.dart';
import '../stroked_text.dart';

class WalletBody extends StatelessWidget 
{
    @override
    Widget build(BuildContext context)
    {
        return Container
        (
            child: Column
            (
                children: <Widget>
                [
                    BalanceComponent(),

                    Container
                    (
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton
                        (
                            color: Colors.red,
                            child: Text("ADD"), onPressed: () {},
                        ),
                    ),

                    PurchaseHistoryComponent()
                ],
            ),
        );
    }

}
