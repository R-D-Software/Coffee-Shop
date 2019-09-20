import 'package:coffee_shop/Business/Database/shop_item_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Language
{
    NOTHING,
    ENGLISH,
    HUNGARIAN
}

class LanguageModel
{
    static Language currentLanguage = Language.ENGLISH;

    static Map<Language, String> noOrder = const
    {
        Language.ENGLISH: "No Order",
        Language.HUNGARIAN: "Nincs Megrendelés"
    };

    static Map<Language, String> home = const
    {
        Language.ENGLISH: "Home",
        Language.HUNGARIAN: "Főképernyő"
    };

    static Map<Language, String> quest = const
    {
        Language.ENGLISH: "Quest",
        Language.HUNGARIAN: "Isten Adta"
    };

    static Map<Language, String> cart = const
    {
        Language.ENGLISH: "Cart",
        Language.HUNGARIAN: "Kosár"
    };

    static Map<Language, String> coffeeOfTheWeek = const
    {
        Language.ENGLISH: "Coffee of the Week",
        Language.HUNGARIAN: "Heti Ajánlat"
    };

    static Map<Language, String> logOut = const
    {
        Language.ENGLISH: "Log Out",
        Language.HUNGARIAN: "Kijelentkezés"
    };

    static Map<Language, String> wallet = const
    {
        Language.ENGLISH: "Wallet",
        Language.HUNGARIAN: "Pénztárca"
    };
    
    static Map<Language, String> favourites = const
    {
        Language.ENGLISH: "Favourites",
        Language.HUNGARIAN: "Kedvencek"
    };
    
    static Map<Language, String> yourBalance = const
    {
        Language.ENGLISH: "Balance: ",
        Language.HUNGARIAN: "Egyenleg: "
    };
    
    static Map<Language, String> add = const
    {
        Language.ENGLISH: "Add",
        Language.HUNGARIAN: "Hozzáad"
    };

    static Map<Language, String> sugar = const
    {
        Language.ENGLISH: "Sugar",
        Language.HUNGARIAN: "Cukor"
    };

    static Map<Language, String> temperature = const
    {
        Language.ENGLISH: "Temperature",
        Language.HUNGARIAN: "Hőmérséklet"
    };
    
    static Map<Language, String> purchaseHistory = const
    {
        Language.ENGLISH: "Purchase History",
        Language.HUNGARIAN: "Vásárlási Előzmények"
    };

    static Map<Language, String> settings = const
    {
        Language.ENGLISH: "Settings",
        Language.HUNGARIAN: "Beállítások"
    };

    static Map<Language, String> language = const
    {
        Language.ENGLISH: "Language",
        Language.HUNGARIAN: "Nyelv"
    };

    static Map<Language, String> deposit = const
    {
        Language.ENGLISH: "Add to Balance",
        Language.HUNGARIAN: "Egyenleg Feltöltése"
    };  
      
    static Map<Language, String> navigatoToShop = const
    {
        Language.ENGLISH: "Navigate to the Shop",
        Language.HUNGARIAN: "Irány a Bolt"
    };  

    static Map<Language, String> coffee = const
    {
        Language.ENGLISH: "Coffee",
        Language.HUNGARIAN: "Kávé"
    };

    static Map<Language, String> sandwich = const
    {
        Language.ENGLISH: "Sandwich",
        Language.HUNGARIAN: "Szendvics"
    };
    
    static Map<Language, String> todaysDeals = const
    {
        Language.ENGLISH: "Today's Deals",
        Language.HUNGARIAN: "Napi ajánlat"
    };
    

    static Future init(BuildContext context) async 
    {
        User user;
        await UserDB.getCurrentUser().then((u)
        {
            user = u;
        });

        if(user != null)
        {
            if(user.userDefinedLanguage == Language.NOTHING || user.userDefinedLanguage == null)
            {
                currentLanguage = _getLocalizedLang(context);
            }
            else
            {
                currentLanguage = user.userDefinedLanguage;
            }
        }
        else
        {
            currentLanguage = _getLocalizedLang(context);
        }
    }

    static String getCurrentLanguageString()
    {
        String ret;
        switch (currentLanguage)
        {
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

    static Language _getLocalizedLang(BuildContext context)
    {
        Locale myLocale = Localizations.localeOf(context);
        Language retLang = Language.ENGLISH;

        switch(myLocale.toString())
        {
            case "hu_HU":
                retLang = Language.HUNGARIAN;
            break;
        }

        return retLang;
    }
}