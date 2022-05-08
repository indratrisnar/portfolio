import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/m_package.dart';

class FirePackage {
  static Future<List<MPackage>> gets() async {
    CollectionReference appReference =
        FirebaseFirestore.instance.collection('Package');
    QuerySnapshot snapshot = await appReference.orderBy('id').get();
    return snapshot.docs.map((e) {
      return MPackage.fromJson((e.data() as Map<String, dynamic>));
    }).toList();
  }

  static Future<List<MPackage>> getLimit() async {
    CollectionReference appReference =
        FirebaseFirestore.instance.collection('Package');
    QuerySnapshot snapshot = await appReference.orderBy('id').limit(5).get();
    return snapshot.docs.map((e) {
      return MPackage.fromJson((e.data() as Map<String, dynamic>));
    }).toList();
  }
}
