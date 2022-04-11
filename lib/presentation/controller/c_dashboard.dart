import 'package:get/get.dart';

import '../../data/model/m_app.dart';
import '../../data/source/fire_app.dart';

class CDashboard extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  void setLoading(n) => _loading.value = n;

  final RxList<MApp> _listApp = <MApp>[].obs;
  List<MApp> get listApp => _listApp;
  void setListApp() async {
    setLoading(true);
    _listApp.value = await FireApp.gets();
    Future.delayed(const Duration(milliseconds: 1500), () => setLoading(false));
  }

  @override
  void onInit() {
    setListApp();
    super.onInit();
  }
}
