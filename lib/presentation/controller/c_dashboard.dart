import 'package:get/get.dart';
import 'package:portfolio/data/model/m_package.dart';
import 'package:portfolio/data/source/fire_package.dart';

import '../../data/model/m_app.dart';
import '../../data/source/fire_app.dart';

class CDashboard extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  void setLoading(n) => _loading.value = n;

  final RxList<MApp> _listApp = <MApp>[].obs;
  List<MApp> get listApp => _listApp;
  final RxList<MPackage> _listPackage = <MPackage>[].obs;
  List<MPackage> get listPackage => _listPackage;
  void setList() async {
    setLoading(true);
    _listApp.value = await FireApp.getLimit();
    _listPackage.value = await FirePackage.getLimit();
    setLoading(false);
  }

  void refreshData() {
    setList();
  }

  @override
  void onInit() {
    setList();
    super.onInit();
  }
}
