import 'package:get/get.dart';

import 'shop_view_all_controller.dart';

class ShopViewAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopViewAllController());
  }
}
