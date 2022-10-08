import 'package:get/get.dart';

import '../controller/npva_controller.dart';

class NPVABinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NPVAController());
  }
}
