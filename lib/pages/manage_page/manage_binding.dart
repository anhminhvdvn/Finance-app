import 'package:baitaplon_mobile/pages/manage_page/manage_controller.dart';
import 'package:get/get.dart';

class ManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManageController());
  }
}
