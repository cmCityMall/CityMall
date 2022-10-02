import 'package:citymall/admin/time_sale/controller/time_sale_controller.dart';
import 'package:get/get.dart';

class TimeSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TimeSaleController());
  }
}
