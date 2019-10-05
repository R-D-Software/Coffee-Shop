import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/Models/user.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _blackVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Icon(
              Icons.free_breakfast,
              color: Theme.of(context).primaryColor,
              size: 125.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Welcome in our Caffee Shop!",
              softWrap: true,
              textAlign: TextAlign.center,
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
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Sign up or Log in to make your order!",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.none,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: RenaoFlatButton(
              title: "Log In",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed("/signin");
              },
              splashColor: Colors.black12,
              borderColor: Theme.of(context).primaryColor,
              borderWidth: 0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: RenaoFlatButton(
              title: "Sign Up",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed("/signup");
              },
              splashColor: Colors.red,
              borderColor: Colors.black12,
              borderWidth: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "OR",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
            child: RenaoFlatButton(
              title: "Continue with Facebook",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              onPressed: () {
                _facebookLogin(context: context);
              },
              splashColor: Colors.black12,
              borderColor: Color.fromRGBO(59, 89, 152, 1.0),
              borderWidth: 0,
              color: Color.fromRGBO(59, 89, 152, 1.0),
            ),
          ),
        ],
      ),
    );
  }

  void _facebookLogin({BuildContext context}) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _changeBlackVisible();
      FacebookLogin facebookLogin = new FacebookLogin();
      FacebookLoginResult facebookLoginResult = await facebookLogin
          .logInWithReadPermissions(['email', 'public_profile']);
      FacebookAccessToken myToken = facebookLoginResult.accessToken;
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: myToken.token);
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.loggedIn:
          Auth.signInWithFacebook(credential).then((uid) {
            Auth.getCurrentFirebaseUser().then((firebaseUser) {
              User user = new User(
                firstName: firebaseUser.displayName,
                userID: firebaseUser.uid,
                email: firebaseUser.email ?? '',
                profilePictureURL: firebaseUser.photoUrl ?? '',
              );
              Auth.addUser(user);
              Navigator.of(context).pop();
            });
          });
          break;
        case FacebookLoginStatus.cancelledByUser:
        case FacebookLoginStatus.error:
          _changeBlackVisible();
      }
    } catch (e) {
      print("Error in facebook sign in: $e");
      _changeBlackVisible();
    }
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }
}
