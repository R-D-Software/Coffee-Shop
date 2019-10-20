import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/order.dart';
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
    
    static Future<int> getMaximumOrderPerMinuteForShop(Shop currentShop) async
    {
        Shop sh = await getShopByID(currentShop.docID);

        if(sh != null)
        {
            return sh.maximumOrderPerMinute;
        }
    }   
    
    ///DONT FUCKING TOUCH THIS SHIT
    static void incrementUsedBoxesWithOrder(Order order) async
    {
        DocumentSnapshot ds = await Firestore.instance.collection("shop_order_times").document(order.shopID)
            .collection(order.yearMonth).document(order.day).get();
        Map<String, dynamic> updatedData = ds.data; 
        
        if(updatedData != null)
        {
            if(updatedData[order.time.split(":")[0]] != null)
            {
                if((updatedData[order.time.split(":")[0]] as Map<dynamic, dynamic>)[order.time.split(":")[1]] != null)
                {
                    (updatedData[order.time.split(":")[0]] as Map<dynamic, dynamic>)[order.time.split(":")[1]]++;
                }
                else
                {
                    (updatedData[order.time.split(":")[0]] as Map<dynamic, dynamic>)[order.time.split(":")[1]] = 1;
                }
            }
            else
            {
                updatedData[order.time.split(":")[0]] = new Map<dynamic,dynamic>();
                (updatedData[order.time.split(":")[0]] as Map<dynamic, dynamic>)[order.time.split(":")[1]] = 1;
            }

            Firestore.instance.collection("shop_order_times").document(order.shopID)
                .collection(order.yearMonth).document(order.day).updateData(updatedData);
        }
        else
        {
            updatedData = new Map<String,dynamic>();
            updatedData[order.time.split(":")[0]] = new Map<dynamic,dynamic>();
            (updatedData[order.time.split(":")[0]] as Map<dynamic, dynamic>)[order.time.split(":")[1]] = 1;

            Firestore.instance.collection("shop_order_times").document(order.shopID)
                .collection(order.yearMonth)
                .document(order.day)
                .setData(updatedData);
        }         
    } 

    static Future<Shop> getShopByID(String shopID) 
    {
        return Firestore.instance.collection("shops").document(shopID).snapshots().first.then((shop)
        {
            return Shop.fromDocument(shop);
        });
    }          
}   
