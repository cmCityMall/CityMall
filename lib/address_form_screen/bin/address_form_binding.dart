import 'package:get/get.dart';
import '../controller/address_controller.dart';

class AddressFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressController());
  }
}
