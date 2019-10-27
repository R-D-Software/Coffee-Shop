import 'package:coffee_shop/Business/Database/order_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_empty_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxBody extends StatefulWidget {
    @override
    _BoxBodyState createState() => _BoxBodyState();
}

class _BoxBodyState extends State<BoxBody> {

  @override
  void initState() {
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                decoration: RenaoBoxDecoration.builder(context),       
                child: StreamBuilder
                (
                    stream: OrderDB.getOrdersForCurrentUser().asStream(),
                    builder: (context, snap)
                    {
                        if(snap.connectionState == ConnectionState.waiting)
                        {
                            return Container();
                        }
                        else
                        {

                            return _buildScreen(context, (snap.data as List<Order>));
                        }
                    },
                ),
            ),
        );
    }

    Widget _buildScreen(BuildContext context, List<Order> orders)
    {
        if(!orders.isEmpty)
        {
            return _noOrderPage(context);
        }

        return Container
        (
            
        );
    }

    Widget _noOrderPage(BuildContext context)
    {
        return RenaoEmptyList
        (
            imagePath: "assets/images/kav.jpg",
            textHeader: LanguageModel.yourListIsEmpty[LanguageModel.currentLanguage],
            textDescription: LanguageModel.addToFavourite[LanguageModel.currentLanguage],
        );
    }
}
