import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  RxDouble quality = 0.0.obs;

  void setQuality(double value) {
    quality.value = value;
  }

  RxDouble customSlider = 0.0.obs;

  void onChange(double value) {
    customSlider.value = value;
  }

  RxString startLabel = 3000.toString().obs;
  RxString endLabel = 10000.toString().obs;

  Rx<RangeValues> values = const RangeValues(3000.0, 10000.0).obs;
// Rx<RangeLabels> labels = RangeLabels(10.toString(), 50.toString()).obs;
}
