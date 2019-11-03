import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';

class CartItemDB {
  static Stream<QuerySnapshot> fetchCartItems() {
    return Firestore.instance.collection("users/${StaticData?.currentUser?.userID}/cart_items").snapshots();
  }

  static modifyOrAddItemToCart(ShopItem item, String buttonLabel) {
    if (buttonLabel == LanguageModel.add[LanguageModel.currentLanguage]) {
      addItemToCart(item);
    } else {
      modifyItemInCart(item);
    }
  }

  static addItemToCart(ShopItem item) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document()
        .setData(item.toJson());
  }

    static addRewardItemToCart(ShopItem item) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document()
        .setData(item.asReward().toJson());
  }

  static modifyItemInCart(ShopItem item) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document('${item.documentID}')
        .updateData(item.toJson());
  }

  static deleteItemFromCart(ShopItem shopItem) {
    Firestore.instance
        .collection("users")
        .document(StaticData.currentUser.userID)
        .collection("cart_items")
        .document(shopItem.documentID)
        .delete();
  }

    static void resetCartForUser() {
        Firestore.instance
            .collection("users")
            .document(StaticData.currentUser.userID)
            .collection("cart_items").getDocuments().then((docs)
            {
                docs.documents.forEach((doc)
                {
                    Firestore.instance
                        .collection("users")
                        .document(StaticData.currentUser.userID)
                        .collection("cart_items").document(doc.documentID).delete();
                });
            });
    } 
}
