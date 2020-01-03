import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDateDB {
  static Stream<QuerySnapshot> getHolidaySnaphosts() {
    return Firestore.instance.collection("holidays").snapshots();
  }

  static Future<List<DateTime>> getHolidays() async {
    Map<String, dynamic> awaitVal;
    List<DateTime> holidays = new List<DateTime>();

    await getHolidaySnaphosts()
        .first
        .then((x) => {awaitVal = x.documents.last.data});

    for (var stamp in awaitVal["nationalHolidays"]) {
      holidays.add((stamp as Timestamp).toDate());
    }
    return holidays;
  }
}
