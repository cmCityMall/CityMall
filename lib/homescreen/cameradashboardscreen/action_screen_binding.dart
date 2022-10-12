import 'package:get/get.dart';

import 'action_screen_controller.dart';

class ActionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ActionController());
  }
}
