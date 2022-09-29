import 'package:get/get.dart';
import '../controller/sc_controller.dart';

class SCBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SCController());
  }
}
