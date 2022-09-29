import 'package:get/get.dart';

import '../controller/mc_controller.dart';

class MCBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MCController());
  }
}
