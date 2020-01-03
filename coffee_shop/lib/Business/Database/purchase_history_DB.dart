import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/purchase_history.dart';
import 'package:coffee_shop/Models/shop_item.dart';

class PurchaseHistoryDB {
  static Future<PurchaseHistory> getPurchaseHistoryForUser(String userID) async {
    DocumentSnapshot ds = await Firestore.instance.collection("purchase_history").document(userID).get();
    PurchaseHistory ph = PurchaseHistory.fromJson(ds.data);

    return ph;
  }

    static Future<void> addPurchaseForUser(String userID, List<ShopItem> cartItems) async {
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

        DocumentSnapshot ds = await Firestore.instance.collection('purchase_history').document(userID).get();
        if((await ds.data) == null)
        {
            Firestore.instance.collection('purchase_history').document(userID).setData({"orders": data});
        }
        else
        {
            Firestore.instance.collection("purchase_history").document(userID).updateData({"orders": FieldValue.arrayUnion(data)});
        }
    } 
}
