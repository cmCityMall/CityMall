import 'dart:developer';

import 'package:citymall/colors/hexandcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorPickerForm extends StatelessWidget {
  const ColorPickerForm({
    Key? key,
    this.height,
    required this.labelText,
    required this.radius,
    required this.selectedColor,
    required this.onColorChanged,
    this.leftPadding,
    this.rightPadding,
  }) : super(key: key);

  final double? height;
  final String labelText;
  final double radius;
  final String selectedColor;
  final double? leftPadding;
  final double? rightPadding;
  final void Function(String value) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding ?? 0, right: rightPadding ?? 0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            labelText,
          )),
          InkWell(
            onTap: () => Get.dialog(
              Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Card(
                      child: Wrap(
                        children: colorList.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                onColorChanged(e);
                                Get.back();
                              },
                              child: CircleAvatar(
                                radius: radius,
                                child: Stack(children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: radius,
                                      backgroundColor: HexColor(e),
                                    ),
                                  ),
                                  selectedColor == e
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            radius: radius,
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ]),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Colors.black38,
              child: CircleAvatar(
                radius: radius - 2,
                backgroundColor: HexColor(selectedColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
