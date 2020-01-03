import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/string_service.dart';
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
        .document(StringService.toDateFormatString(day)).get();
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
        String hour = order.time.split(":")[0];
        String minute = order.time.split(":")[1];

        if(updatedData != null)
        {
            if(updatedData[hour] != null)
            {
                if((updatedData[hour] as Map<dynamic, dynamic>)[minute] != null)
                {
                    (updatedData[hour] as Map<dynamic, dynamic>)[minute]++;
                }
                else
                {
                    (updatedData[hour] as Map<dynamic, dynamic>)[minute] = 1;
                }
            }
            else
            {
                updatedData[hour] = new Map<dynamic,dynamic>();
                (updatedData[hour] as Map<dynamic, dynamic>)[minute] = 1;
            }

            Firestore.instance.collection("shop_order_times").document(order.shopID)
                .collection(order.yearMonth).document(order.day).updateData(updatedData);
        }
        else
        {
            updatedData = new Map<String,dynamic>();
            updatedData[hour] = new Map<dynamic,dynamic>();
            (updatedData[hour] as Map<dynamic, dynamic>)[minute] = 1;

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

    static Future<String> freeBoxAtShop(String shopID, String ownerID, String yearMonth, String day, int pickedHour, int pickedMinute) async 
    {
        Shop s = await getShopByID(shopID); 
        String freeBox = "2";

        DocumentSnapshot ds = await Firestore.instance.document('shops/' + shopID + "/box_times/" + yearMonth).get();
        Map<dynamic,dynamic> boxTimes = (ds.data as Map<dynamic,dynamic>);

        for(String boxID in s.boxes)
        {
            final DocumentReference boxRef = Firestore.instance.document('boxes/' + boxID);

          /*  await Firestore.instance.runTransaction((Transaction tran){
                tran.get(boxRef).then((DocumentSnapshot snap){
                if(snap.exists)
                {
                    if((snap.data["empty"] as bool) == true)
                    {
                        freeBox = boxID;
                        tran.update(boxRef, <String,dynamic>{"empty": false});
                        tran.update(boxRef, <String,dynamic>{"ownerUserID": ownerID});
                    }
                }
                });
            });*/
        }
        
        return freeBox;
    }          
}   
