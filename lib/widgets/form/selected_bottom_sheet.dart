import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../admin/sub_category/view/sc_view.dart';

class SelectedBottomSheet extends StatelessWidget {
  final String hint;
  final bool isEmpty;
  final String selectedValue;
  final List<String> list;
  final void Function(String value) setSelectedId;
  final void Function(String value) setSelectedIdError;
  const SelectedBottomSheet({
    Key? key,
    required this.setSelectedId,
    required this.setSelectedIdError,
    required this.hint,
    required this.isEmpty,
    required this.selectedValue,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            color: Colors.grey.shade300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final shop = list[index];
                return TextButton(
                  onPressed: () {
                    setSelectedId(shop);
                    setSelectedIdError("");
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    color: selectedValue == shop
                        ? Colors.blue
                        : Colors.grey.shade300,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      shop,
                      style: TextStyle(
                        color:
                            selectedValue == shop ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      child: UpDownChoice(
        items: const [],
        hint: hint,
        increase: () {},
        decrease: () {},
        isEmpty: isEmpty,
        selectedValue: selectedValue,
      ),
    );
  }
}
