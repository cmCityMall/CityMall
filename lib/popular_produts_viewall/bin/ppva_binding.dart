import 'package:get/get.dart';

import '../controller/ppva_controller.dart';

class PPVABinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PPVAController());
  }
}
