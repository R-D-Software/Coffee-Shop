import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/OrderPageWidgets/timepicker_component.dart';

class OrderDB
{
    ///Returns a logical value depending on the success of the order placement.
    static Future<bool> placeOrder({TimePickerComponent timePicker, User currentUser, Shop currentShop, String yearMonth, String day, List<ShopItem> cartItems}) async
    {
        if(! await _canPlaceOrder(timePicker, currentShop, yearMonth, day))
        {
            return false;
        }

        List<String> itemIDs = cartItems.map((f){return f.parentID;}).toList();

        Order order = Order
        (
            shopID: currentShop.docID, 
            userID: StaticData.currentUser.userID, 
            yearMonth: yearMonth,
            day: day,
            date: yearMonth + "." + day,
            time: timePicker.pickedHour.toString() + ":" + timePicker.pickedMinute.toString(),
            items: itemIDs
        );

        Firestore.instance.collection("orders").add(order.toJson());
        ShopsDB.incrementUsedBoxesWithOrder(order);
        CartItemDB.resetCartForUser();

        return true;
    }
    
    static Future<bool> _canPlaceOrder(TimePickerComponent timePicker, Shop currentShop, String yearMonth, String day) async
    {
        DocumentSnapshot ds = await ShopsDB.getCrowdedTimes(currentShop.docID, yearMonth, day);
        List<int> notPickableList = await OrderDB.getNotPickableMinutes(timePicker.pickedHour, ds.data, currentShop);

        if(notPickableList.contains(timePicker.pickedMinute))
        {
            return false;
        }
        
        return true;
    }

    static Future<List<int>> getNotPickableMinutes(int currentHour, Map<String, dynamic> notSelectableDates, Shop currentShop) async
    {
        List<int> notPickableMinutes = new List<int>();
        int maxOrderAtMin = await ShopsDB.getMaximumOrderPerMinuteForShop(currentShop);

        if(notSelectableDates != null)
        {
            if(notSelectableDates.containsKey(currentHour.toString()))
            {
                for(String minute in (notSelectableDates[currentHour.toString()] as Map<dynamic, dynamic>).keys)
                {
                    if(notSelectableDates[currentHour.toString()][minute] > maxOrderAtMin)
                    {
                        notPickableMinutes.add(int.parse(minute));
                    }
                }
            }
        }
        
        return notPickableMinutes;
    }

    static Future<List<Order>> getOrdersForCurrentUser() async
    {
        List<Order> orders = new List<Order>();

        Query q = Firestore.instance.collection("orders").where("userID", isEqualTo: StaticData.currentUser.userID);
        
        await q.getDocuments().then((res)
        {
            res.documents.forEach((doc)
            {
                orders.add(Order.fromJson(doc.data, doc.documentID));
            });
        });
        return orders;
    }

    static void deleteOrder(String docID)
    {
        print(docID);
        Firestore.instance.collection("orders").document(docID).delete();
    }
}