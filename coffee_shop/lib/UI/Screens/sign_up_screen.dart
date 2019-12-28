import 'dart:core';

import 'package:coffee_shop/Business/Database/shops_DB.dart';
import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/Business/validator.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_alert_dialog.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_text_field.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/signup';
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  RenaoTextField _emailField;
  RenaoTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _emailField = new RenaoTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = RenaoTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Password",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Container(
          //TODO: háttérképet beállítani
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage("assets/images/signup_background_image.jpg"),
//              fit: BoxFit.cover,
//            ),
//          ),
          child: Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                        child: Text(
                          "Create new account",
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.none,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                        child: _emailField,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                        child: _passwordField,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
                        child: RenaoFlatButton(
                          title: LanguageModel.signUp[LanguageModel.currentLanguage],
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          onPressed: () {
                            _signUp(email: _email.text, password: _password.text);
                          },
                          splashColor: Colors.black12,
                          borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                          borderWidth: 0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: onBackPress,
                    ),
                  ),
                ],
              ),
              Offstage(
                offstage: !_blackVisible,
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedOpacity(
                    opacity: _blackVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _signUp({String email, String password, BuildContext context}) async {
    String firstShop = await ShopsDB.getFirstShop();
    if (Validator.validateEmail(email) && Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signUp(email, password).then((uID) {
          Auth.addUser(new User(
              userID: uID,
              email: email,
              profilePictureURL: '',
              firstName: "",
              userDefinedLanguage: Language.NOTHING,
              completedQuestPart: 0,
              favouriteItems: [],
              selectedShop: firstShop,
              currentOrders: []));
          onBackPress();
        });
      } catch (e) {
        print("Error in sign up: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Signup failed",
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  void _showErrorAlert({String title, String content, Function onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return RenaoAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}
