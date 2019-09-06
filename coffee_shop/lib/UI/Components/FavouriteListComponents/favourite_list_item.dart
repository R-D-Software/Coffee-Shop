import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class FavouriteListItem extends StatelessWidget 
{
    final ShopItem item;

    FavouriteListItem({@required this.item});

    @override
    Widget build(BuildContext context) 
    {
        return Stack
        (
            children: <Widget>
            [
                _getInfoRow(context),
                _getPicture(context),
            ],
        );
    }

    Widget _getPicture(BuildContext context)
    {
        return Card
        (
            margin: EdgeInsets.only(top: 20,left: 20),
            shape: RoundedRectangleBorder
            (
                borderRadius: BorderRadius.circular(35.0),
            ),
            elevation: 2,
            child:Container
            (
                width: 70,
                height: 70,
                decoration: new BoxDecoration
                (
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage
                    (
                        image: AssetImage(item.imagePath),
                        fit: BoxFit.fill
                    ),
                ),
            )
        );
    }

    Widget _getInfoRow(BuildContext context)
    {
        return Container
        (
            width: MediaQuery.of(context).size.width - (20 + 70),
            height: 50,
            margin: EdgeInsets.only(top: 25, left: 70),
            padding: EdgeInsets.only(left: 25),
            child: Row
            (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                    StrokedText(text: item.name, color: Colors.white, size:20),
                    Icon(Icons.delete)
                ],
            ),
            decoration: BoxDecoration
            (
                border: Border.all(color: Colors.white, width: 2),
                color: Color.fromRGBO(189,150,150,1),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10))
            ),
        );
    }
}