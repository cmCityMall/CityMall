import 'package:citymall/discount_product_viewall/controller/dpva_controller.dart';
import 'package:get/get.dart';

class DPVABinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DPVAController());
  }
}
