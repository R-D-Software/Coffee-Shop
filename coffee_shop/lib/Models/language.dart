import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:flutter/material.dart';

enum Language { NOTHING, ENGLISH, HUNGARIAN }

class LanguageModel {
  static Language currentLanguage = Language.ENGLISH;

  static Map<Language, String> noOrder = const {
    Language.ENGLISH: "No Order",
    Language.HUNGARIAN: "Nincs Megrendelés"
  };

  static Map<Language, String> home = const {
    Language.ENGLISH: "Home",
    Language.HUNGARIAN: "Főképernyő"
  };

  static Map<Language, String> quest = const {
    Language.ENGLISH: "Quest",
    Language.HUNGARIAN: "Isten Adta"
  };

  static Map<Language, String> cart = const {
    Language.ENGLISH: "Cart",
    Language.HUNGARIAN: "Kosár"
  };

  static Map<Language, String> coffeeOfTheWeek = const {
    Language.ENGLISH: "Coffee of the Week",
    Language.HUNGARIAN: "Heti Ajánlat"
  };

  static Map<Language, String> logOut = const {
    Language.ENGLISH: "Log Out",
    Language.HUNGARIAN: "Kijelentkezés"
  };

  static Map<Language, String> wallet = const {
    Language.ENGLISH: "Wallet",
    Language.HUNGARIAN: "Pénztárca"
  };

  static Map<Language, String> favourites = const {
    Language.ENGLISH: "Favourites",
    Language.HUNGARIAN: "Kedvencek"
  };

  static Map<Language, String> yourBalance = const {
    Language.ENGLISH: "Balance: ",
    Language.HUNGARIAN: "Egyenleg: "
  };

  static Map<Language, String> add = const {
    Language.ENGLISH: "Add",
    Language.HUNGARIAN: "Hozzáad"
  };

  static Map<Language, String> sugar = const {
    Language.ENGLISH: "Sugar",
    Language.HUNGARIAN: "Cukor"
  };

  static Map<Language, String> temperature = const {
    Language.ENGLISH: "Temperature",
    Language.HUNGARIAN: "Hőmérséklet"
  };

  static Map<Language, String> purchaseHistory = const {
    Language.ENGLISH: "Purchase History",
    Language.HUNGARIAN: "Vásárlási Előzmények"
  };

  static Map<Language, String> settings = const {
    Language.ENGLISH: "Settings",
    Language.HUNGARIAN: "Beállítások"
  };

  static Map<Language, String> language = const {
    Language.ENGLISH: "Language",
    Language.HUNGARIAN: "Nyelv"
  };

  static Map<Language, String> deposit = const {
    Language.ENGLISH: "Add to Balance",
    Language.HUNGARIAN: "Egyenleg Feltöltése"
  };

  static Map<Language, String> navigatoToShop = const {
    Language.ENGLISH: "Navigate to the Shop",
    Language.HUNGARIAN: "Irány a Bolt"
  };

  static Map<Language, String> coffee = const {
    Language.ENGLISH: "Coffee",
    Language.HUNGARIAN: "Kávé"
  };

  static Map<Language, String> sandwich = const {
    Language.ENGLISH: "Sandwich",
    Language.HUNGARIAN: "Szendvics"
  };

  static Map<Language, String> todaysDeals = const {
    Language.ENGLISH: "Today's Deals",
    Language.HUNGARIAN: "Napi ajánlat"
  };

  static Map<Language, String> addToFavourite = const {
    Language.ENGLISH:
        "To add something to your favourite list, please tap on the star icon in the product view.",
    Language.HUNGARIAN:
        "Ahhoz, hogy a kedvencek listához tudd adni egy terméket, a termék képe fölötti csillagra kell kattintanod."
  };

  static Map<Language, String> yourListIsEmpty = const {
    Language.ENGLISH: "Your list is empty",
    Language.HUNGARIAN: "A listád üres"
  };

  static Map<Language, String> addToCart = const {
    Language.ENGLISH: "Add to Cart",
    Language.HUNGARIAN: "Kosárba"
  };

  static Map<Language, String> questComplete = const {
    Language.ENGLISH: "Congratulation, You have completed the quest!",
    Language.HUNGARIAN: "Gratulálunk, nyertél!"
  };

  static Map<Language, String> toastAddToCart = const {
    Language.ENGLISH: " was added to your cart",
    Language.HUNGARIAN: " hozzáadásra került"
  };

  static Map<Language, String> time = const {
    Language.ENGLISH: "Time",
    Language.HUNGARIAN: "Időpont"
  };

  static Map<Language, String> order = const {
    Language.ENGLISH: "Order",
    Language.HUNGARIAN: "Megrendel"
  };

  static Map<Language, String> selectedPlace = const {
    Language.ENGLISH: "Selected Place",
    Language.HUNGARIAN: "Kiválasztott Hely"
  };

  static Map<Language, String> date = const {
    Language.ENGLISH: "Date",
    Language.HUNGARIAN: "Nap"
  };

  static Map<Language, String> withoutSugar = const {
    Language.ENGLISH: "Sugarfree",
    Language.HUNGARIAN: "Cukormentes"
  };

  static Map<Language, String> modify = const {
    Language.ENGLISH: "Modify",
    Language.HUNGARIAN: "Módosítás"
  };

  static Map<Language, String> iceCold = const {
    Language.ENGLISH: "Ice cold",
    Language.HUNGARIAN: "Jég hideg"
  };  
  
  static Map<Language, String> cold = const {
    Language.ENGLISH: "Cold",
    Language.HUNGARIAN: "Hideg"
  }; 

  static Map<Language, String> warm = const {
    Language.ENGLISH: "Warm",
    Language.HUNGARIAN: "Meleg"
  }; 

  static Map<Language, String> hot = const {
    Language.ENGLISH: "Hot",
    Language.HUNGARIAN: "Forró"
  }; 


  static Future init(BuildContext context) async {
    User user;
    await UserDB.getCurrentUser().then((u) {
      user = u;
    });

    if (user != null) {
      if (user.userDefinedLanguage == Language.NOTHING ||
          user.userDefinedLanguage == null) {
        currentLanguage = _getLocalizedLang(context);
      } else {
        currentLanguage = user.userDefinedLanguage;
      }
    } else {
      currentLanguage = _getLocalizedLang(context);
    }
  }

  static String getCurrentLanguageString() {
    String ret;
    switch (currentLanguage) {
      case Language.ENGLISH:
        ret = "English";
        break;

      case Language.HUNGARIAN:
        ret = "Magyar";
        break;

      case Language.NOTHING:
      default:
        ret = "English";
        break;
    }

    return ret;
  }

  static Language _getLocalizedLang(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    Language retLang = Language.ENGLISH;

    switch (myLocale.toString()) {
      case "hu_HU":
        retLang = Language.HUNGARIAN;
        break;
    }

    return retLang;
  }

  static String questOrder(int missingParts, String itemName) {
    switch (currentLanguage) {
      case Language.NOTHING:
        return "Order " +
            missingParts.toString() +
            " more " +
            itemName +
            " to get a free one!";
        break;

      case Language.ENGLISH:
        return "Order " +
            missingParts.toString() +
            " more " +
            itemName +
            " to get a free one!";
        break;

      case Language.HUNGARIAN:
        return "Rendelj még " +
            missingParts.toString() +
            " " +
            itemName +
            "t és egyet ingyen vihetsz!";
        break;
    }
  }

  static total(int total) {
    switch (currentLanguage) {
      case Language.NOTHING:
        return "Total: " + total.toString();
        break;

      case Language.ENGLISH:
        return "Total: " + total.toString();
        break;

      case Language.HUNGARIAN:
        return "Végösszeg: " + total.toString();
        break;
    }
  }
}
