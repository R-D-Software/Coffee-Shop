import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/purchase_history.dart';
import 'package:coffee_shop/Models/shop_item.dart';

class PurchaseHistoryDB {
  static Future<PurchaseHistory> getPurchaseHistoryForUser(String userID) async {
    DocumentSnapshot ds = await Firestore.instance.collection("purchase_history").document(userID).get();
    PurchaseHistory ph = PurchaseHistory.fromJson(ds.data);

    return ph;
  }

  static void addPurchaseForUser(String userID, List<ShopItem> cartItems) {
    List<Map<String, dynamic>> data = new List<Map<String, dynamic>>();

    for (ShopItem item in cartItems) {
      data.add({
        "date": DateTime.now().year.toString() +
            "." +
            DateTime.now().month.toString() +
            "." +
            DateTime.now().day.toString(),
        "itemName": item.name,
        "price": item.price.toString()
      });
    }

    //TODO: HA nincs dokumentum akkor létre kell hozni
    Firestore.instance
        .collection("purchase_history")
        .document(userID)
        .updateData({"orders": FieldValue.arrayUnion(data)});
  }
}
