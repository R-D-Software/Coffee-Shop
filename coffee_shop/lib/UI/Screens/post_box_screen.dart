import 'package:coffee_shop/Models/language.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PostBoxScreen extends StatefulWidget {
  PostBoxScreen({Key key}) : super(key: key);

  @override
  _PostBoxScreenState createState() => _PostBoxScreenState();
}

class _PostBoxScreenState extends State<PostBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(LanguageModel.postBox[LanguageModel.currentLanguage]),
    );
  }

  Container _buildBody(BuildContext context) {
    return Container();
  }

  Future<NetworkImage> get _openBoxImage async {
    final ref = FirebaseStorage.instance.ref().child('box_open.jpg');
    var url = await ref.getDownloadURL();
    return NetworkImage(url);
  }

  Future<NetworkImage> get _closedBoxImage async {
    final ref = FirebaseStorage.instance.ref().child('box_closed.jpg');
    var url = await ref.getDownloadURL();
    return NetworkImage(url);
  }
}
