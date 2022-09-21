import 'package:get/get.dart';

class CartCounterController extends GetxController {
  List<int> count = [
    0,
    0,
    0,
  ].obs;

  increment(int index) {
    count[index]++;
    update();
  }

  decrement(int index) {
    count[index]--;
    update();
  }
}