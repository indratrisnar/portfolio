import 'package:get/get.dart';
import '../../data/model/m_package.dart';
import '../../data/source/fire_package.dart';

class CPackages extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  void setLoading(n) => _loading.value = n;

  final RxList<MPackage> _list = <MPackage>[].obs;
  List<MPackage> get list => _list;
  void setList() async {
    setLoading(true);
    _list.value = await FirePackage.gets();
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
