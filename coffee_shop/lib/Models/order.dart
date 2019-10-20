import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Order
{
    final String userID;
    final List<String> items;
    final String shopID;
    final String date;
    final String time;
    final String yearMonth;
    final String day;

    Order
    (
        {   
            @required this.userID,
            @required this.items,
            @required this.shopID,
            @required this.date,
            @required this.time,
            @required this.yearMonth,
            @required this.day,
        }
    );

    Map<String, dynamic> toJson() 
    {
        return 
        {
            'userID': userID,
            'items': items,
            'shopID': shopID,
            'date': date,
            'time': time,
            'yearMonth': yearMonth,
            'day': day,
            'appIdentifier': 'Renao'
        };
    }

    factory Order.fromJson(Map<String, Object> doc) 
    {
        Order order = new Order
        (
            userID: doc['userID'],
            items: (doc['items'] as List<dynamic>).map((f)
            {
                return f.toString();
            }).toList(),
            shopID: doc['shopID'],
            date: doc['date'],
            time: doc['time'],
            yearMonth: doc['yearMonth'],
            day: doc['day'],
        );

        return order;
    }

    factory Order.fromDocument(DocumentSnapshot doc) 
    {
        return Order.fromJson(doc.data);
    }
}