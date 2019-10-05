import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/shop_item.dart';

class DecideItemType {
  static ShopItem getItemByClassFromFireStore(DocumentSnapshot doc) {
    ShopItem item;
    try {
      item = CoffeeItem.fromDocument(doc, doc.documentID);
    } catch (e) {
      item = ShopItem.fromDocument(doc, doc.documentID);
    }
    return item;
  }
}
