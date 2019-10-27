import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Models/post_box.dart';

class BoxesDB {
  static Stream fetchBoxes() {
    return Firestore.instance.collection("boxes").snapshots();
  }

  static addBox(PostBox box) {
    Firestore.instance.collection("boxes").document().setData(box.toJson());
  }
}
