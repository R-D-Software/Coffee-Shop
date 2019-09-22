import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/dummy_data.dart';
import 'package:coffee_shop/Models/favourite_item.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/FavouriteListComponents/favourite_list_item.dart';
import 'package:flutter/material.dart';

class FavouriteListScreen extends StatefulWidget 
{
    @override
    _FavouriteListScreenState createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> 
{
    double height = 0;

    @override
    Widget build(BuildContext context) 
    {
        MediaQueryData mData = MediaQuery.of(context);       
        height = mData.size.height;
        List<ShopItem> favourites;
        favourites = DummyData.items;       

        return Scaffold
        (
            appBar: AppBar
            (
                centerTitle: true,
                title: Icon(Icons.star),
            ),
            body: Container
            (
                child: makeFavListBody(),
                decoration: RenaoBoxDecoration.builder(context)
            ),
        );
    }

    Widget _getFavouriteList(List<ShopItem> items)
    {
        return ListView
        (
            children: items.map((f) => Container
            (
                margin: EdgeInsets.only(right: 7),
                child: FavouriteListItem(item: f),
            )).toList(),
        );
    }

    Widget _getEmptyList()
    {
        return Container
        (
            child: Center
            (
                child: Text("NINCS"),
            ),
        );
    }

    Widget makeFavListBody()
    {
        return StreamBuilder
        (
            stream: UserDB.getUser(StaticData.currentUser.userID),
            builder: (context, snapshot) 
            {
                User user = snapshot.data as User;

                if(user == null || snapshot.connectionState == ConnectionState.waiting) 
                {
                    return Container();
                }

                return StreamBuilder
                (
                    stream: ShopItemDB.getShopItems(),
                    builder: (context1, snapshot1) 
                    {
                        QuerySnapshot items = snapshot1.data as QuerySnapshot;
                        List<ShopItem> favouriteItems = new List<ShopItem>();

                        if(items == null) return Container();

                        for(String itemID in user.favouriteItems)
                        {
                            for(DocumentSnapshot doc in items.documents)
                            {
                                if(itemID == doc.documentID)
                                {
                                    favouriteItems.add(ShopItem.fromDocument(doc, doc.documentID));
                                }
                            }
                        }

                        if(favouriteItems.isNotEmpty) 
                            return _getFavouriteList(favouriteItems);
                        else return _getEmptyList();
                    }
                );
            }
        );
    }
}