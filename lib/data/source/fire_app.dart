import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/m_app.dart';

class FireApp {
  static Future<List<MApp>> gets() async {
    CollectionReference appReference =
        FirebaseFirestore.instance.collection('App');
    QuerySnapshot snapshot = await appReference.get();
    return snapshot.docs.map((e) {
      return MApp(
        id: (e.data() as Map<String, dynamic>)['id'],
        name: (e.data() as Map<String, dynamic>)['name'],
        cover: (e.data() as Map<String, dynamic>)['cover'],
      );
    }).toList();
  }

  static Future<List<MApp>> getLimit() async {
    CollectionReference appReference =
        FirebaseFirestore.instance.collection('App');
    QuerySnapshot snapshot = await appReference.orderBy('name').limit(3).get();
    return snapshot.docs.map((e) {
      return MApp(
        id: (e.data() as Map<String, dynamic>)['id'],
        name: (e.data() as Map<String, dynamic>)['name'],
        cover: (e.data() as Map<String, dynamic>)['cover'],
      );
    }).toList();
  }

  static Future<MApp?> whereId(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('App').doc(id).get();
    if (doc.exists) return MApp.fromJson(doc.data() as Map<String, dynamic>);
    return null;
  }
}
