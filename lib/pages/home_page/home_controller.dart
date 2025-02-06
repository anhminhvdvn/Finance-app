import 'package:get/get.dart';

import '../manage_page/manage_controller.dart';

class HomeController extends GetxController {
  final managecontroller = Get.put(ManageController());
  RxString userName = "Phạm Ngọc Minh".obs;
  RxDouble moneyleft = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
