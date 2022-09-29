import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cips.freezed.dart';

@freezed
class CIPS with _$CIPS {
  factory CIPS({
    required String color,
    required String image,
    required bool isFileImage,
    required TextEditingController price,
    required TextEditingController size,
  }) = _CIPS;

  factory CIPS.initial() => CIPS(
        color: "",
        image: "",
        isFileImage: false,
        price: TextEditingController(),
        size: TextEditingController(),
      );
}
