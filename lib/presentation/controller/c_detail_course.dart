import 'package:get/get.dart';
import '../../data/model/m_course.dart';
import '../../data/source/fire_course.dart';

class CDetailCourse extends GetxController {
  final Rx<MCourse> _mCourse = MCourse().obs;
  MCourse get mCourse => _mCourse.value;
  void setMCourse(String id) async {
    _mCourse.value = await FireCourse.whereId(id);
  }
}
