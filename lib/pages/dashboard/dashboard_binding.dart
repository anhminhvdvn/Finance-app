import 'package:baitaplon_mobile/pages/category_page/category_controller.dart';
import 'package:baitaplon_mobile/pages/item_page/Item_controller.dart';
import 'package:get/get.dart';
import '../home_page/home_controller.dart';
import 'dashboard_controller.dart';

class NavigateBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<ItemController>(() => ItemController());
  }
}
