import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/Models/language.dart';

class User 
{
    final String userID;
    final String firstName;
    final String email;
    final String profilePictureURL;
    Language userDefinedLanguage;

    User(
    {
        this.userID,
        this.firstName,
        this.email,
        this.profilePictureURL,
        this.userDefinedLanguage
    });

    Map<String, Object> toJson() 
    {
        return 
        {
        'userID': userID,
        'firstName': firstName,
        'email': email == null ? '' : email,
        'profilePictureURL': profilePictureURL,
        'userDefinedLanguage': _getUserDefinedLanguageToString(),
        'appIdentifier': 'Renao'
        };
    }

    factory User.fromJson(Map<String, Object> doc) 
    {
        User user = new User
        (
            userID: doc['userID'],
            firstName: doc['firstName'],
            email: doc['email'],
            userDefinedLanguage: _getUserDefinedLanguageFromString(doc['userDefinedLanguage']),
            profilePictureURL: doc['profilePictureURL'],
        );
        return user;
    }

    factory User.fromDocument(DocumentSnapshot doc) 
    {
        return User.fromJson(doc.data);
    }
    
    static Language _getUserDefinedLanguageFromString(String lang)
    {
        Language retVal;
        switch (lang)
        {
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

    String _getUserDefinedLanguageToString()
    {
        String retVal = "-1";
        
        switch (userDefinedLanguage)
        {
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

    void setUserDefinedLanguage(String lang) 
    {
        switch (lang)
        {
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

        Auth.modifyUserLanguage(this);
        LanguageModel.currentLanguage = userDefinedLanguage;
    }
}
