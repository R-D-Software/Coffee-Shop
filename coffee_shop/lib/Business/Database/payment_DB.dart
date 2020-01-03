import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/Data/barion_api_service.dart';
import 'package:coffee_shop/Models/Barion/barion_payment.dart';

class PaymentDB {
  static Future writePaymentDataIntoDb(String paymentId, String userID) async {
    Firestore.instance.collection("payment").where("userID", isEqualTo: userID).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    }).then((_) => {
          Firestore.instance
              .collection("payment")
              .document(paymentId)
              .setData({"userID": userID, "serverModifiedCount": 0}),
        });
  }

  static Future checkForPaymentStatusChange() async {
    CollectionReference reference = Firestore.instance.collection('payment');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) async {
        if (change.type != DocumentChangeType.removed) {
          await BarionApiService.create()
              .getPaymentState("a3b3a7967c9043729a914472ea093991", change.document.documentID)
              .then((response) async {
            print(response);
          });
        }
      });
    });
  }

  static Future<bool> wasPaymentSuccessful(String userID) async {
    bool wasSuccessful = false;
    await Firestore.instance
        .collection("payment")
        .where("userID", isEqualTo: userID)
        .getDocuments()
        .then((snapshot) async {
      final paymentId = snapshot.documents.first.documentID;
      final response = await BarionApiService.create().getPaymentState(BuiltBarionPayment.renaoPOSKey, paymentId);
      if (response.body["Status"] == "Succeeded") {
        wasSuccessful = true;
      }
    });
    return wasSuccessful;
  }
}
