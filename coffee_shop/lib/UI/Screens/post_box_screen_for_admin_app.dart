import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Business/Database/boxes_DB.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/Models/post_box.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_waiting_ring.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PostBoxScreenForAdminApp extends StatefulWidget {
  PostBoxScreenForAdminApp({Key key}) : super(key: key);

  @override
  _PostBoxScreenForAdminAppState createState() => _PostBoxScreenForAdminAppState();
}

class _PostBoxScreenForAdminAppState extends State<PostBoxScreenForAdminApp> {
  List<PostBox> arrengedBoxes;
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
    return Container(
      decoration: RenaoBoxDecoration.builder(context),
      child: StreamBuilder(
          stream: BoxesDB.fetchBoxes(),
          builder: (context, _boxesSnapshot) {
            QuerySnapshot boxes = _boxesSnapshot.data as QuerySnapshot;
            if (boxes != null && arrengedBoxes == null) {
              arrengedBoxes = arrangeBoxes(boxes);
              return GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: List.generate(arrengedBoxes.length, (index) {
                    return Center(
                      child: buildBox(arrengedBoxes[index]),
                    );
                  }));
            } else {
              return Container();
            }
          }),
    );
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

  buildPostBox(DocumentSnapshot doc) {
    return Text('asd');
  }

  Widget buildBox(PostBox box) {
    return StreamBuilder(
      stream: box.empty ? Stream.fromFuture(_closedBoxImage) : Stream.fromFuture(_openBoxImage),
      builder: (context, _image) {
        switch (_image.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: RenaoWaitingRing(),
            );
          default:
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Text(
                "${box.number}",
                style: TextStyle(fontSize: 40, color: Theme.of(context).primaryColor),
              )),
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: _image.data),
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
            );
        }
      },
    );
  }

  List<PostBox> arrangeBoxes(QuerySnapshot boxes) {
    List<PostBox> _boxes = [];
    List<PostBox> _arrendgedBoxes = [];
    for (DocumentSnapshot doc in boxes.documents) {
      _boxes.add(PostBox.fromDocument(doc, doc.documentID));
    }
    int i = 1;
    while (i != _boxes.length + 1) {
      for (PostBox _box in _boxes) {
        if (_box.number == i) {
          _arrendgedBoxes.add(_box);
          i++;
        }
      }
    }
    return _arrendgedBoxes;
  }
}
