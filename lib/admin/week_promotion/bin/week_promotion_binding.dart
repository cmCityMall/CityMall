import 'package:citymall/admin/week_promotion/controller/week_promotion_controller.dart';
import 'package:get/get.dart';

class WeekPromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WeekPromotionController());
  }
}
