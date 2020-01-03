import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:flutter/foundation.dart';

class Order {
  final String userID;
  final List<ShopItem> items;
  final String shopID;
  final String date;
  final String time;
  final String yearMonth;
  final String day;
  final String orderID;
  final String box;

  Order({
    @required this.userID,
    @required this.items,
    @required this.shopID,
    @required this.date,
    @required this.time,
    @required this.yearMonth,
    @required this.day,
    @required this.orderID,
    @required this.box,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'items': items.map((item) => item.toJson()).toList(),
      'shopID': shopID,
      'date': date,
      'time': time,
      'yearMonth': yearMonth,
      'day': day,
      'box': box,
      'appIdentifier': 'Renao'
    };
  }

  factory Order.fromJson(Map<String, Object> doc, String orderID) {
    List<ShopItem> items = new List<ShopItem>();
    for (dynamic item in doc['items'] as List) {
      ShopItem it = ShopItem.fromCartItemJson(item);
      if (it != null) {
        items.add(it);
      }
    }

    Order order = new Order(
      userID: doc['userID'],
      items: items,
      shopID: doc['shopID'],
      date: doc['date'],
      time: doc['time'],
      yearMonth: doc['yearMonth'],
      day: doc['day'],
      box: doc['box'],
      orderID: orderID,
    );

    return order;
  }

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order.fromJson(doc.data, doc.documentID);
  }

  DateTime toDateTime() {
    String formattedString = date.toString() + "T" + _timeToMinute() + "";
    formattedString = formattedString.replaceAll(RegExp("\\."), "");
    formattedString = formattedString.replaceAll(RegExp(":"), "");
    return DateTime.parse(formattedString);
  }

  String _timeToMinute() {
    String hour = time.split(":")[0];
    String minute = time.split(":")[1];

    if (hour.length == 1) {
      hour = "0" + hour;
    }

    if (minute.length == 1) {
      minute = "0" + minute;
    }

    return hour + ":" + minute + ":" + "00";
  }

  static Order getNearestOrder(List<Order> orders) {
    Order retOrder = orders.first;
    for (Order order in orders) {
      if (retOrder.toDateTime().compareTo(order.toDateTime()) > 0) {
        retOrder = order;
      }
    }
    return retOrder;
  }
}
