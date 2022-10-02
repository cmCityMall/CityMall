import 'package:get/get.dart';

import '../controller/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopController());
  }
}
