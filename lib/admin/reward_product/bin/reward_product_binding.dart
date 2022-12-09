import 'package:get/get.dart';

import '../controller/reward_product_controller.dart';

class RewardProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RewardProductController());
  }
}
