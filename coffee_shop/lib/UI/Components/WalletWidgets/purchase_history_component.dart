import 'package:coffee_shop/Business/Database/purchase_history_DB.dart';
import 'package:coffee_shop/Models/purchase_history.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryComponent extends StatefulWidget 
{
    final double height;
    PurchaseHistoryComponent({@required this.height});

    @override
    _PurchaseHistoryComponentState createState() => _PurchaseHistoryComponentState();
}

class _PurchaseHistoryComponentState extends State<PurchaseHistoryComponent> 
{
    @override
    Widget build(BuildContext context) 
    {
        return StreamBuilder
        (
            stream: PurchaseHistoryDB.getPurchaseHistoryForUser(StaticData.currentUser.userID).asStream(),
            builder: (context, snap)
            {
                if(snap.connectionState == ConnectionState.waiting)
                {
                    return Container
                    (
                        width: MediaQuery.of(context).size.width*0.98,
                        //height: widget.height,
                    );
                }
                else
                {
                    List<Widget> historyItems = new List<Widget>();

                    PurchaseHistory ph = (snap.data as PurchaseHistory);

                    if(ph == null)
                    {
                        return Container();
                    }

                    for(PurchaseHistoryItem item in ph.items)
                    {
                        historyItems.add(_getHistoryElement(context, item));
                    }

                    return Container
                    (
                        width: MediaQuery.of(context).size.width*0.98,
                        //height: widget.height,
                        child: ListView
                        (
                            children: historyItems.length == 0 ? [Container()] : historyItems
                        )
                    );
                }
            },
        );
    }

    Widget _getHistoryElement(BuildContext context, PurchaseHistoryItem item)
    {
        return Container
        (
            height: 45,
            child: Card
            (
                color: Colors.transparent,
                child: Row
                (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>
                    [
                        Padding
                        (
                            padding: const EdgeInsets.only(left: 10),
                            child: StrokedText(text: item.date),
                        ),
                        StrokedText(text: item.itemName),
                        Padding
                        (
                            padding: const EdgeInsets.only(right: 10),
                            child: StrokedText(text: item.price),
                        ),
                    ],
                ),
            ),
        );
    }
}