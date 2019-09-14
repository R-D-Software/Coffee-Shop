import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/stroked_text.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget 
{
    @override
    _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> 
{
    String dropdownValue;
    double height = 0;
    User user;
    
    @override
    Future initState() 
    {
        Auth.getCurrentUser().then((u)
        {
            user = u;
        });

        dropdownValue = LanguageModel.getCurrentLanguageString();
        super.initState();
    }

    @override
    Widget build(BuildContext context) 
    {
        MediaQueryData mData = MediaQuery.of(context);       
        
        if(mData.orientation == Orientation.portrait)
        {
            height = mData.size.height;
        }
        else
        {
            height = mData.size.width;
        }

        return Scaffold
        (
            appBar: AppBar
            (
                centerTitle: true,
                title: Icon(Icons.settings),
            ),
            body: Container
            (
                child: ListView
                (
                    children: <Widget>
                    [
                        _settingsItem()
                    ],
                ),
                decoration: RenaoBoxDecoration.builder(context)
            ),
        );
    }

    Row _settingsItem()
    {
        return Row
        (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>
            [
                Container
                (
                    margin: EdgeInsets.only(left: 15),
                    child: Text
                    (
                        LanguageModel.language[LanguageModel.currentLanguage], 
                        style: TextStyle
                        (
                            color: Colors.white,
                            fontSize: 22,
                        ),
                    )
                ),
                Container
                (
                    margin: EdgeInsets.only(right: 15),
                    child: DropdownButton<String>
                    (
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle
                        (
                            color: Colors.white
                        ),
                        underline: Container
                        (
                            height: 2,
                            color: Colors.white,
                        ),
                        onChanged: (String newValue) 
                        {
                            setState(() 
                            {
                                user.setUserDefinedLanguage(newValue);
                                print(user.userDefinedLanguage);
                                dropdownValue = newValue;
                            });
                        },
                        items: <String>["Magyar", "English"]
                        .map<DropdownMenuItem<String>>((String value)
                        {
                            return DropdownMenuItem<String>
                            (
                                value: value,
                                child: Text
                                (
                                    value,
                                    style: TextStyle
                                    (
                                        color: Colors.black
                                    ),
                                ),
                            );
                        }).toList(),
                    ),
                ),
            ],
        );
    }
}