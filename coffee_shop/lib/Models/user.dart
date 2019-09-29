import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/favourite_item.dart';
import 'package:coffee_shop/Models/language.dart';

class User {
  final String userID;
  final String firstName;
  final String email;
  final String profilePictureURL;
  Language userDefinedLanguage;
  List<String> favouriteItems = new List<String>();
  //List<FavouriteItem> favItems = new List<FavouriteItem>();

  User(
      {this.userID,
      this.firstName,
      this.email,
      this.profilePictureURL,
      this.userDefinedLanguage,
      //this.favItems,
      this.favouriteItems});

  Map<String, Object> toJson() {
    //DONT DELETE IT YET
    /*List<Object> boj = new List<Object>();

        for(FavouriteItem item in favItems)
        {
            boj.add({"itemID": item.itemID, "temperature": item.temperature, "sugar": item.sugar});
        }*/

    return {
      'userID': userID,
      'firstName': firstName,
      'email': email == null ? '' : email,
      'profilePictureURL': profilePictureURL,
      'userDefinedLanguage': _getUserDefinedLanguageToString(),
      'favouriteItems': favouriteItems,
      'appIdentifier': 'Renao'
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      userID: doc['userID'],
      firstName: doc['firstName'],
      email: doc['email'],
      userDefinedLanguage:
          _getUserDefinedLanguageFromString(doc['userDefinedLanguage']),
      profilePictureURL: doc['profilePictureURL'],
      favouriteItems: doc["favouriteItems"] != null
          ? List.from(doc["favouriteItems"])
          : new List<String>(),
    );

    return user;
  }

  static List<FavouriteItem> getFavouriteItems(List<Object> objects) {
    List<FavouriteItem> retVal = new List<FavouriteItem>();

    for (Object object in objects) {
      Map jsonData = Map.from(object);
      retVal.add(new FavouriteItem(
          itemID: jsonData["itemID"],
          sugar: jsonData["sugar"],
          temperature: jsonData["temperature"]));
    }

    return retVal;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }

  static Language _getUserDefinedLanguageFromString(String lang) {
    Language retVal;
    switch (lang) {
      case "English":
        retVal = Language.ENGLISH;
        break;

      case "Magyar":
        retVal = Language.HUNGARIAN;
        break;

      case "-1":
        retVal = Language.NOTHING;
        break;
    }

    return retVal;
  }

  String _getUserDefinedLanguageToString() {
    String retVal = "-1";

    switch (userDefinedLanguage) {
      case Language.ENGLISH:
        retVal = "English";
        break;

      case Language.HUNGARIAN:
        retVal = "Magyar";
        break;

      case Language.NOTHING:
      default:
        retVal = "-1";
        break;
    }

    return retVal;
  }

  void setUserDefinedLanguage(String lang) {
    switch (lang) {
      case "English":
        userDefinedLanguage = Language.ENGLISH;
        break;

      case "Magyar":
        userDefinedLanguage = Language.HUNGARIAN;
        break;

      case "-1":
      default:
        userDefinedLanguage = Language.NOTHING;
        break;
    }

    UserDB.modifyUserLanguage(this);
    LanguageModel.currentLanguage = userDefinedLanguage;
  }
}
