import 'package:get/get.dart';

import '../../data/model/m_app.dart';
import '../../data/source/fire_app.dart';

class CApps extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  void setLoading(n) => _loading.value = n;

  final RxList<MApp> _list = <MApp>[].obs;
  List<MApp> get list => _list;
  void setListApp() async {
    setLoading(true);
    _list.value = await FireApp.gets();
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
