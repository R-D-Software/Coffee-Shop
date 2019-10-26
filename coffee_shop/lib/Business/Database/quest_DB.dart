import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/quest.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/static_data.dart';

//questCompletedBy value:
enum QuestStatus
{
    ITEM_NOT_ACQUIRED,
    ITEM_ACQUIRED_NOT_USED,
    ITEM_ADDED_TO_CART,
    ITEM_ORDERED
}

QuestStatus enumFromInt(int val)
{
    return QuestStatus.values[val-1];
}

int intValOfEnum(QuestStatus e)
{
    return (QuestStatus.values.indexOf(e) + 1);
}

class QuestDB
{
    static Future<DocumentSnapshot> getCurrentQuestData()
    {
        return Firestore.instance.collection("quest").document("currentQuest").snapshots().first;
    }

    static Future<void> addQuestCounterForUserIfLegit(List<ShopItem> cartItems) async
    {
        DocumentSnapshot ds = await getCurrentQuestData();
        int sumOfPoints = 0;
        int requiredAmount = ((ds["row"] as int) * (ds["column"]) as int);
        
        for(ShopItem i in cartItems)
        {
            if(i.parentID == ds["questItemID"])
            {
                sumOfPoints++;
            }
        }

        if(sumOfPoints != 0)
        {
            UserDB.incrementCurrentUserQuestItemCountBy(sumOfPoints, requiredAmount, ds["calendarWeek"]);
        }
    }

    static void setQuestStatus(String userID, QuestStatus questStatus, int calendarWeek) 
    {
        String collectionName = DateTime.now().year.toString() + "CW" + calendarWeek.toString();       
        Firestore.instance.collection("quest").document("questCompletedBy")
            .collection(collectionName)
            .document(userID)
            .setData({"questVal": intValOfEnum(questStatus)});
    }

    static void changeQuestStatusIfNeeded(List<ShopItem> cartItems) async
    {
        DocumentSnapshot ds = await getCurrentQuestData();
        Quest quest = Quest.fromDocument(ds, 0);

        for(ShopItem item in cartItems)
        {
            if(item.price == 0)
            {
                setQuestStatus(StaticData.currentUser.userID, QuestStatus.ITEM_ORDERED, quest.calendarWeek);
                return;
            }
        }
    }

    static Future<QuestStatus> getQuestStatusForUser(String userID, int calendarWeek) async
    {
        String collectionName = DateTime.now().year.toString() + "CW" + calendarWeek.toString();
        DocumentSnapshot ds = await Firestore.instance.collection("quest").document("questCompletedBy").collection(collectionName).document(userID).get();
        
        if(ds.data == null)
            return QuestStatus.ITEM_NOT_ACQUIRED;

        return enumFromInt(ds.data["questVal"]);
    }

    static void changeQuestStatusIfNeededUpponDelete(ShopItem item) async
    {
        DocumentSnapshot ds = await getCurrentQuestData();
        Quest quest = Quest.fromDocument(ds, 0);

        QuestStatus qs = await getQuestStatusForUser(StaticData.currentUser.userID, quest.calendarWeek);
        if(item.price == 0 && qs == QuestStatus.ITEM_ADDED_TO_CART)
        {
            setQuestStatus(StaticData.currentUser.userID, QuestStatus.ITEM_ACQUIRED_NOT_USED, quest.calendarWeek);
        }
    }
}