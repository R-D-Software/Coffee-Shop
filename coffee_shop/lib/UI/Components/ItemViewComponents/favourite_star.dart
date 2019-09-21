import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:flutter/material.dart';

class FavouriteStar extends StatefulWidget 
{
    final String itemID;

    FavouriteStar({this.itemID});

    @override
    _FavouriteStarState createState() => _FavouriteStarState();
}

class _FavouriteStarState extends State<FavouriteStar> with SingleTickerProviderStateMixin 
{
    AnimationController _controller;
    bool starState = false;

    @override
    void initState() 
    {
        super.initState();
        _controller = AnimationController(vsync: this);
    }

    @override
    void dispose() 
    {
        super.dispose();
        _controller.dispose();
    }

    @override
    Widget build(BuildContext context) 
    {
        return StreamBuilder
        (
            stream: UserDB.getCurrentUser().asStream(),
            builder: (context, snapshot)
            {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                    return buildStar(false);
                }
                else
                {
                    return initStar(snapshot);
                }
            },
        );
    }

    Widget initStar(AsyncSnapshot snapshot)
    {
        User user = snapshot.data as User;
        starState = user.favouriteItems.contains(widget.itemID);  

        return buildStar(starState);      
    }

    Widget buildStar(bool state)
    {
        return GestureDetector
        (
            child: Container
            (
                child: Icon
                (
                    Icons.star,
                    size: 50,
                    color: state ? Colors.yellow: Colors.white,
                ),
                margin: EdgeInsets.only(top: 2),
            ),
            onTap: starLogic,
        );
    }

    starLogic()
    {
        setState(() 
        {
            starState = !starState;
        });
        UserDB.modifyFavouriteByItemID(widget.itemID, StaticData.currentUser);
    }
}