import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';

class CartItemDB {
  static Stream<QuerySnapshot> fetchCartItems() {
    return Firestore.instance.collection("users/${StaticData.currentUser.userID}/cart_items").snapshots();
  }

  static addItemToCart(ShopItem item) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document()
        .setData(item.toJson());
  }

  static deleteItemFromCart(ShopItem shopItem) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document(shopItem.documentID)
        .delete();
  }
}
