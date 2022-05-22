import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/m_course.dart';

class FireCourse {
  static Future<List<MCourse>> gets() async {
    CollectionReference appReference =
        FirebaseFirestore.instance.collection('Course');
    QuerySnapshot snapshot = await appReference.orderBy('name').get();
    return snapshot.docs.map((e) {
      return MCourse.fromJson((e.data() as Map<String, dynamic>));
    }).toList();
  }

  static Future<List<MCourse>> getLimit() async {
    CollectionReference appReference =
        FirebaseFirestore.instance.collection('Course');
    QuerySnapshot snapshot = await appReference.orderBy('name').limit(3).get();
    return snapshot.docs.map((e) {
      return MCourse(
        idCourse: (e.data() as Map<String, dynamic>)['id_course'],
        name: (e.data() as Map<String, dynamic>)['name'],
        cover: (e.data() as Map<String, dynamic>)['cover'],
      );
    }).toList();
  }

  static Future<MCourse> whereId(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('Course').doc(id).get();
    if (doc.exists) return MCourse.fromJson(doc.data() as Map<String, dynamic>);
    return MCourse();
  }
}
