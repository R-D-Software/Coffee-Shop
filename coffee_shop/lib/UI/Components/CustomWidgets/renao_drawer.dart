import 'package:coffee_shop/Business/auth.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/DrawerComponents/drawer_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RenaoDrawer extends StatefulWidget {
  @override
  _RenaoDrawerState createState() => _RenaoDrawerState();
}

class _RenaoDrawerState extends State<RenaoDrawer> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, user) {
          print(user);
          return Drawer(
            child: Container(
              color: Color.fromRGBO(89, 62, 55, 1),
              child: ListView(
                children: <Widget>[
                  _buildUserAccountsDrawerHeader(user),
                  ...listTiles
                ],
              ),
            ),
          );
        });
  }

  UserAccountsDrawerHeader _buildUserAccountsDrawerHeader(AsyncSnapshot<FirebaseUser> user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.data?.displayName ?? ""),
      accountEmail: Text(user.data?.email ?? ""),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(user.data?.photoUrl ??
              'https://cdn.pixabay.com/photo/2017/12/01/18/16/coffe-2991458_960_720.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://scontent.fbud3-1.fna.fbcdn.net/v/t1.0-9/20476162_1547163528677502_2166447578135575306_n.jpg?_nc_cat=108&_nc_oc=AQl6ch2h89Ct4th5KZVJpw6TpjTuV88OuFit3HtSGfQtvjX9R_XjQ-f27oQkDDV9rFY&_nc_ht=scontent.fbud3-1.fna&oh=85e3d6f97a7a922d980f6068a61f0d18&oe=5DF6DDB0")),
    );
  }

  List<Widget> get listTiles {
    List<Widget> listTiles = List();
    listTiles.add(DrawerListTile(iconData: Icons.star, text: LanguageModel.favourites[LanguageModel.currentLanguage], action: _moveToFavouritesScreen));
    listTiles.add(DrawerListTile(iconData: Icons.account_balance_wallet, text: LanguageModel.wallet[LanguageModel.currentLanguage], action: _moveToWalletScreen));
    listTiles.add(DrawerListTile(iconData: Icons.settings, text: LanguageModel.settings[LanguageModel.currentLanguage], action: _moveToSettingsScreen));
    listTiles.add(Divider(color: Colors.orange));
    listTiles.add(DrawerListTile(iconData: Icons.power_settings_new, text: LanguageModel.logOut[LanguageModel.currentLanguage], action: _logOut));
    return listTiles;
  }

  void _logOut() async {
    Auth.signOut();
  }

  void _moveToFavouritesScreen() {
    Navigator.of(context).pushNamed("/main/favourites");
  }

  void _moveToWalletScreen() {
    Navigator.of(context).pushNamed("/main/wallet");
  }

  void _moveToSettingsScreen() {
    Navigator.of(context).pushNamed("/main/settings");
  }
}
