import 'package:cloud_firestore/cloud_firestore.dart';
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
}