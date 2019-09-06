import 'package:coffee_shop/Models/dummy_data.dart';
import 'package:coffee_shop/Models/shop_item.dart';
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
        List<ShopItem> favourites;
        favourites = DummyData.items;
        
        MediaQueryData mData = MediaQuery.of(context);       
        
        if(mData.orientation == Orientation.portrait)
        {
            height = mData.size.height;
        }
        else
        {
            height = mData.size.width;
        }

        return Scaffold
        (
            appBar: AppBar
            (
                centerTitle: true,
                title: Icon(Icons.star),
            ),
            body: Container
            (
                child: favourites.isNotEmpty ?
                _getFavouriteList(favourites)
                :
                _getEmptyList(),

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
        return Column
        (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
                
            ],
        );
    }
}