import 'package:citymall/categorybrandscreen/brand_view_all_controller.dart';
import 'package:get/get.dart';

class BrandViewAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BrandViewAllController());
  }
}
