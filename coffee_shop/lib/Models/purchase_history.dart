import 'package:flutter/foundation.dart';

class PurchaseHistory
{
    final List<PurchaseHistoryItem> items;

    PurchaseHistory({@required this.items});

    factory PurchaseHistory.fromJson(Map<String, dynamic> data) 
    {
        List<PurchaseHistoryItem> items = new List<PurchaseHistoryItem>();

        for(Map<dynamic,dynamic> item in (data["orders"] as List<dynamic>))
        {
            items.add(
                PurchaseHistoryItem
                (
                    date: item["date"],
                    itemName: item["itemName"],
                    price: item["price"],
                )
            );
        }

        return PurchaseHistory
        (
            items: items 
        );   
    }
}

class PurchaseHistoryItem
{
    final String date;
    final String itemName;
    final String price;

    PurchaseHistoryItem({@required this.date, @required this.itemName, @required this.price});
}
