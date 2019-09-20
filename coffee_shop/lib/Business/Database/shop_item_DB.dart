import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shop_item.dart';

class ShopItemDB
{
    List<ShopItem> shopItems = new List<ShopItem>();

    static Stream<ShopItem> getShopItemByID(String itemID) {
        print("the itemid is : " + itemID);
        return Firestore.instance
            .collection("shop_items")
            .where("itemID", isEqualTo: itemID)
            .snapshots()
            .map((QuerySnapshot snapshot) {
        return snapshot.documents.map((doc) {
            return ShopItem.fromDocument(doc, doc.documentID);
        }).first;
        });
    }
}