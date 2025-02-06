import 'package:get/get.dart';
import '../history_page/history_controller.dart';
import '../home_page/home_controller.dart';
import '../manage_page/manage_controller.dart';
import 'dashboard_controller.dart';

class NavigateBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ManageController>(() => ManageController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    // HistoryBinding().dependencies();
  }
}
