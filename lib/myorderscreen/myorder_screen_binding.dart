import 'package:citymall/myorderscreen/my_order_screen_controller.dart';
import 'package:get/get.dart';

class MyOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyOrderScreenController());
  }
}
