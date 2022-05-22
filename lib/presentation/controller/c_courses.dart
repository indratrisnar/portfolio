import 'package:get/get.dart';
import '../../data/model/m_course.dart';
import '../../data/source/fire_course.dart';

class CCourses extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  void setLoading(n) => _loading.value = n;

  final RxList<MCourse> _list = <MCourse>[].obs;
  List<MCourse> get list => _list;
  void setListApp() async {
    setLoading(true);
    _list.value = await FireCourse.gets();
    setLoading(false);
  }

  void refreshData() {
    setListApp();
  }

  @override
  void onInit() {
    setListApp();
    super.onInit();
  }
}
