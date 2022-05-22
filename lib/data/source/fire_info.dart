import 'package:cloud_firestore/cloud_firestore.dart';

class FireInfo {
  static Future<Map> profile() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Info')
        .doc('Profile')
        .get();
    return doc.data() as Map<String, dynamic>;
  }
}
