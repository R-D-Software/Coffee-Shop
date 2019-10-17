import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shops.dart';

class ShopsDB 
{
    static Stream<QuerySnapshot> getShops() 
    {
        return Firestore.instance.collection("shops").snapshots();
    }

    static Future<DocumentSnapshot> getCrowdedTimes(String shopID, String yearMonth, String day) 
    {
        return Firestore.instance.collection("shop_order_times").document(shopID)
        .collection(yearMonth)
        .document(day).get();
    }
    
    static Future<String> getFirstShop() 
    {
        return Firestore.instance.collection("shops").snapshots().first.then((shop)
        {
            return Shop.fromDocument(shop.documents.first).docID;
        });
    }   
}   
