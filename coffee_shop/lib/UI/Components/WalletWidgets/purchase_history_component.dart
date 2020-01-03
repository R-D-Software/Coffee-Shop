import 'package:coffee_shop/Business/Database/purchase_history_DB.dart';
import 'package:coffee_shop/Models/purchase_history.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryComponent extends StatefulWidget 
{
    final double height;
    final double maxElementHeight = 42;
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
                        height: widget.height,
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
                        height: widget.height,
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
        double elementHeight = (widget.height*0.37 > widget.maxElementHeight ? widget.maxElementHeight : widget.height*0.37);
       
        return Container
        (
            height: elementHeight,
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
                            padding: EdgeInsets.only(left: 10),
                            child: StrokedText(text: item.date, size: elementHeight*0.45),
                        ),
                        StrokedText(text: item.itemName, size: elementHeight*0.45),
                        Padding
                        (
                            padding: EdgeInsets.only(right: 10),
                            child: StrokedText(text: item.price, size: elementHeight*0.45),
                        ),
                    ],
                ),
            ),
        );
    }
}