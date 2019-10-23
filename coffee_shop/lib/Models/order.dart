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
    final String docID;

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
            @required this.docID,
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
            'docID': docID,
            'appIdentifier': 'Renao'
        };
    }

    factory Order.fromJson(Map<String, Object> doc, String docID) 
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
            docID: docID,
        );

        return order;
    }

    factory Order.fromDocument(DocumentSnapshot doc) 
    {
        return Order.fromJson(doc.data, doc.documentID);
    }

    DateTime toDateTime() 
    {
        String formattedString = date.toString() + "T" + _timeToMinute() + "";
        formattedString = formattedString.replaceAll(RegExp("\\."), "");
        formattedString = formattedString.replaceAll(RegExp(":"), "");
        return DateTime.parse(formattedString);
    }

    String _timeToMinute()
    {
        String hour = time.split(":")[0];
        String minute = time.split(":")[1];

        if(hour.length == 1)
        {
            hour = "0" + hour;
        }

        if(minute.length == 1)
        {
            minute = "0" + minute;
        }

        return hour + ":" + minute + ":" + "00";
    }
}