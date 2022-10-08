import 'package:citymall/homescreen/subcategoryview_all/controller/scva_controller.dart';
import 'package:get/get.dart';

class SCVABinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SCVAController());
  }
}
