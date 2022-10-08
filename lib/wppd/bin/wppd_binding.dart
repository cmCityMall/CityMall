import 'package:citymall/flashsale_product_detail/controller/fspd_controller.dart';
import 'package:citymall/wppd/controller/wppd_controller.dart';
import 'package:get/get.dart';

class WPPDBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WPPDController());
  }
}
