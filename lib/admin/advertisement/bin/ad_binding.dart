import 'package:get/get.dart';

import '../controller/ad_controller.dart';

class ADBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ADController());
  }
}
