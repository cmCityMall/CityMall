import 'package:get/get.dart';

class SwitchController extends GetxController {
  RxBool on1 = false.obs;

  void toggle() => on1.value = on1.value ? false : true;

  RxBool on2 = false.obs;

  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on3 = false.obs;

  void toggle3() => on3.value = on3.value ? false : true;
}