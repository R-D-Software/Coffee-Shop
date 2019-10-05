import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Cart/cart.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';

class CartItemDB {
  static Future fetchCartItems() async {
    var coffeeItems = await _getCartItems();
    return Cart(coffeeItems);
  }

  static Future<List<CoffeeItem>> _getCartItems() async {
    List<DocumentSnapshot> templist;
    List<CoffeeItem> list = [];
    CollectionReference collectionRef = Firestore.instance
        .collection("users/${StaticData.currentUser.userID}/cart_items");
    QuerySnapshot collectionSnapshot = await collectionRef.getDocuments();
    templist = collectionSnapshot.documents;
    list = templist.map((DocumentSnapshot docSnapshot) {
      return CoffeeItem.fromDocument(docSnapshot, docSnapshot.documentID);
    }).toList();

    return list;
  }

  static addItemToCart(ShopItem item) {
    if (item is CoffeeItem) {
      Firestore.instance
          .collection("users")
          .document(StaticData.currentUser.userID)
          .collection("cart_items")
          .document()
          .setData(item.toJson());
    }
  }

  static deleteItemFromCart(CoffeeItem cofeeItem) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document(cofeeItem.documentID)
        .delete();
  }
}
