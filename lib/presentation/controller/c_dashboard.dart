import 'package:get/get.dart';
import 'package:portfolio/data/model/m_package.dart';
import 'package:portfolio/data/source/fire_info.dart';
import 'package:portfolio/data/source/fire_package.dart';

import '../../data/model/m_app.dart';
import '../../data/model/m_course.dart';
import '../../data/source/fire_app.dart';
import '../../data/source/fire_course.dart';

class CDashboard extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  void setLoading(n) => _loading.value = n;

  final RxList<MApp> _listApp = <MApp>[].obs;
  List<MApp> get listApp => _listApp;
  final RxList<MPackage> _listPackage = <MPackage>[].obs;
  List<MPackage> get listPackage => _listPackage;
  final RxList<MCourse> _listCourse = <MCourse>[].obs;
  List<MCourse> get listCourse => _listCourse;

  void setList() async {
    setLoading(true);
    _listApp.value = await FireApp.getLimit();
    _listPackage.value = await FirePackage.getLimit();
    _listCourse.value = await FireCourse.getLimit();
    setLoading(false);
  }

  final RxMap _profile = {}.obs;
  Map get profile => _profile.value;
  getProfile() async {
    _profile.value = await FireInfo.profile();
  }

  void refreshData() {
    getProfile();
    setList();
  }

  @override
  void onInit() {
    getProfile();
    setList();

    super.onInit();
  }
}
