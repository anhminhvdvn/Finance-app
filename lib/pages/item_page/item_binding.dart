import 'package:baitaplon_mobile/pages/item_page/Item_controller.dart';
import 'package:get/get.dart';

class ManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemController());
  }
}
