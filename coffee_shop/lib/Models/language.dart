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
        Language.ENGLISH: "Your Balance: ",
        Language.HUNGARIAN: "Az Egyenleged: "
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

    static Future init(BuildContext context) async 
    {
        User user;
        await Auth.getCurrentUser().then((u)
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

        print(currentLanguage);
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