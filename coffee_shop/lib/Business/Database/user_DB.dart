import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/shop_item.dart';
import 'package:coffee_shop/Models/shops.dart';
import 'package:coffee_shop/Models/static_data.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDB
{
    static Future<User> getCurrentUser() async 
    {
        User user;
        FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
        await getUser(fUser.uid).first.then((u)
        {
            user = u;
        });

        StaticData.currentUser = user;
        return user;  
    }

    static Stream<User> getUser(String userID) {
        return Firestore.instance
            .collection("users")
            .where("userID", isEqualTo: userID)
            .snapshots()
            .map((QuerySnapshot snapshot) {
        return snapshot.documents.map((doc) {
            return User.fromDocument(doc);
        }).first;
        });
    }

    static void modifyUserLanguage(User modifiedUser)
    {
        Firestore.instance.collection("users").document(modifiedUser.userID).updateData(modifiedUser.toJson());
    }

    static void modifyFavouriteByItemID(String itemID, User user) 
    {
        if(user.favouriteItems.contains(itemID))
        {
            user.favouriteItems.remove(itemID);
            removeItemFromFavourites(itemID, user.userID);
        }
        else
        {
            user.favouriteItems.add(itemID);
            addItemToFavourites(itemID, user.userID);
        }
    }
            
    static void removeItemFromFavourites(String itemID, String userID) 
    {
        Firestore.instance.collection("users").document(userID).updateData({"favouriteItems": FieldValue.arrayRemove([itemID])});
    }

    static void addItemToFavourites(String itemID, String userID) 
    {
        Firestore.instance.collection("users").document(userID).updateData({"favouriteItems": FieldValue.arrayUnion([itemID])});
    }

    static void updateSelectedShop(String shopID) 
    {
        Firestore.instance.collection("users").document(StaticData.currentUser.userID).updateData({"selectedShop": shopID});
        StaticData.currentUser.selectedShop = shopID;
    }

    static Stream<Shop> getCurrentUserSelectedShop() 
    {
        return Firestore.instance
            .collection("shops").document(StaticData.currentUser.selectedShop)
            .snapshots()
            .map((DocumentSnapshot snapshot) {
                print(snapshot);
                return Shop.fromDocument(snapshot);
        });
    }   
}