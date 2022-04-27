import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/m_app.dart';

class FireApp {
  static Future<List<MApp>> gets() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('App').get();
    return snapshot.docs
        .map((e) => MApp.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<MApp?> whereId(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('App').doc(id).get();
    if (doc.exists) return MApp.fromJson(doc.data() as Map<String, dynamic>);
    return null;
  }
}
