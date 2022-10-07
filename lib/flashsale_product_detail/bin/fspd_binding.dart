import 'package:citymall/flashsale_product_detail/controller/fspd_controller.dart';
import 'package:get/get.dart';

class FSPDBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FSPDController());
  }
}
