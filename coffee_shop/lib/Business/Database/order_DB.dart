import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/cart_item_DB.dart';
import 'package:coffee_shop/Business/Database/purchase_history_DB.dart';
import 'package:coffee_shop/Business/Database/quest_DB.dart';
import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Business/notification_service.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/order.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/OrderPageWidgets/timepicker_component.dart';
import 'package:flutter/cupertino.dart';

class OrderDB
{
    ///Returns a logical value depending on the success of the order placement.
    static Future<bool> placeOrder(BuildContext context,{TimePickerComponent timePicker, User currentUser, Shop currentShop, String yearMonth, String day, List<ShopItem> cartItems}) async
    {
        bool hasCredit = true;
        List<String> itemIDs = cartItems.map((f){return f.parentID;}).toList();
        //String freeBox = await ShopsDB.freeBoxAtShop(currentShop.docID, currentUser.userID, yearMonth, day, timePicker.pickedHour, timePicker.pickedMinute);

        if(! await _canPlaceOrder(timePicker, currentShop, yearMonth, day))
        {
            return false;
        }
        /*if(freeBox == "-1")
        {
            return false;
        }*/
        
        Order order = Order
        (
            shopID: currentShop.docID, 
            userID: StaticData.currentUser.userID, 
            yearMonth: yearMonth,
            day: day,
            date: yearMonth + "." + day,
            time: timePicker.pickedHour.toString() + ":" + timePicker.pickedMinute.toString(),
            items: itemIDs,
            box: "-1",
        );
        if(order == null)
        {
            return false;
        }
        
        await NotificationService.makeNotification
        (
            LanguageModel.orderIsDue[LanguageModel.currentLanguage],
            LanguageModel.orderReadyAt(currentShop.toString(), cartItems),
            order.toDateTime()
        );

        if(hasCredit)
        {
            await QuestDB.addQuestCounterForUserIfLegit(cartItems);
            DocumentReference df = await Firestore.instance.collection("orders").add(order.toJson());
            QuestDB.changeQuestStatusIfNeeded(cartItems);
            UserDB.addOrderToCurrentUser(df.documentID);
            ShopsDB.incrementUsedBoxesWithOrder(order);
            CartItemDB.resetCartForUser();
            PurchaseHistoryDB.addPurchaseForUser(StaticData.currentUser.userID, cartItems);
        }

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
                    if(notSelectableDates[currentHour.toString()][minute] >= maxOrderAtMin)
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
        User u = await UserDB.getCurrentUser();

        for(String orderID in u.currentOrders)
        {       
            DocumentSnapshot doc = await Firestore.instance.collection("orders").document(orderID).snapshots().first;
            if(doc.data != null)
            {
                Order order = Order.fromJson(doc.data, doc.documentID);
                if(order != null)
                    orders.add(order);
            }
        }

        return orders;
    }

    static void deleteOrder(String docID)
    {
        Firestore.instance.collection("orders").document(docID).delete();
    }

    static Stream<DocumentSnapshot> getOrder(String docID) 
    {
        return Firestore.instance.document("orders/" + docID).snapshots();
    }
}