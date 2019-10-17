import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:flutter/material.dart';

class PlaceChangerScreen extends StatelessWidget 
{
    @override
    Widget build(BuildContext context) 
    {
        //_initializeData(context);

        return Scaffold
        (
            appBar: AppBar(),
            body: Container
            (
                child: StreamBuilder
                (
                    stream: ShopsDB.getShops(),
                    builder: (context, snapshot)
                    {
                        if(snapshot.connectionState == ConnectionState.waiting)
                        {
                            return Container();
                        }
                        else
                        {
                            return _buildShopList(context, snapshot);
                        }
                    },
                )
            )
        );
    }

    Widget _buildShopList(BuildContext context, AsyncSnapshot snapshot)
    {
        Shops shops = Shops.fromDocument((snapshot.data as QuerySnapshot).documents);

        return ListView
        (
            children: <Widget>
            [
                for(Shop shop in shops.items)
                    _buildItem(context, shop),  
            ],
        );
    }

    Widget _buildItem(BuildContext context, Shop shop)
    {
        return GestureDetector
        (
            onTap: () async
            {
                await UserDB.updateSelectedShop(shop.docID);
                Navigator.of(context).pop(shop);
            },
            child: Card
            (
                child: Padding
                (
                    padding: const EdgeInsets.all(8.0),
                    child: Row
                    (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>
                        [
                            Image.network
                            (
                                shop.imageURL,
                                height: 80,
                                width: 80,
                            ),   
                            Text(shop.toString()),      
                        ],
                    ),
                ),
            )
        );
    }
}