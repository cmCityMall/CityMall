import 'package:citymall/admin/orders/controller/order_main_controller.dart';
import 'package:get/get.dart';

class OrderMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderMainController());
  }
}
