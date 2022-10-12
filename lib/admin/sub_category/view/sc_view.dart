import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../../../colors/colors.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/text_form.dart';
import '../controller/sc_controller.dart';

class SCView extends StatelessWidget {
  const SCView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SCController scController = Get.find();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Sub Categories",
          style: TextStyle(
            color: Colors.black,
          ),
        )),
        actions: [
          Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 10,
                right: 10,
                bottom: 10,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorResources.blue1,
                ),
                onPressed: () => scController.save(),
                child: const Text("Save"),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Obx(() {
          return Form(
            key: scController.formKey,
            autovalidateMode: scController.isFirstTimePressed.value
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /**Form*/
                CustomTextForm(
                  padding: 0,
                  rightPadding: 45,
                  height: 85,
                  maxLines: 1,
                  textFieldPaddingLeft: 10,
                  controller: scController.nameController,
                  isUnderlineBorder: false,
                  validator: scController.validate,
                  labelText: "Ad Name",
                ),
                Obx(() {
                  final pickedImage = scController.pickedImage.value;
                  final isEmpty = pickedImage.isEmpty;
                  return ImagePickForm(
                    labelText: isEmpty ? "pick an image" : pickedImage,
                    pickImage: () => scController.pickImage(),
                  );
                }),
                Obx(() {
                  return SizedBox(
                    height: 25,
                    child: Text(scController.pickedImageError.value,
                        style: const TextStyle(
                          color: Colors.red,
                        )),
                  );
                }),
                Obx(() {
                  return InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          color: Colors.grey.shade300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: scController.mainCategories.length,
                            itemBuilder: (context, index) {
                              final cat = scController.mainCategories[index];
                              return TextButton(
                                onPressed: () {
                                  scController.setSelectedParentId(cat.name);
                                  scController.setParentError("");
                                  Get.back();
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: scController.selectedParentId.value ==
                                          cat.name
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    cat.name,
                                    style: TextStyle(
                                      color:
                                          scController.selectedParentId.value ==
                                                  cat.name
                                              ? Colors.white
                                              : Colors.black,
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
                      items: scController.mainCategories,
                      hint: "Select Main Category",
                      isError: scController.isFirstTimePressed.value &&
                          scController.selectedParentId.isEmpty,
                      increase: scController.increaseIndex,
                      decrease: scController.decreaseIndex,
                      isEmpty: scController.selectedParentId.isEmpty,
                      selectedValue: scController.selectedParentId.value,
                    ),
                  );
                }),
                Obx(() {
                  return SizedBox(
                    height: 25,
                    child: Text(scController.selectedParentError.value,
                        style: const TextStyle(
                          color: Colors.red,
                        )),
                  );
                }),
                const SizedBox(height: 15),
                /**Advertisement List*/
                Expanded(
                  child: Obx(
                    () {
                      if (scController.subCatgories.isEmpty) {
                        return const Center(
                            child: Text(
                          "No sub categories yet....",
                        ));
                      }

                      return ListView.builder(
                        itemCount: scController.subCatgories.length,
                        itemBuilder: (context, index) {
                          var subCategory = scController.subCatgories[index];

                          return SwipeActionCell(
                            key: ValueKey(subCategory.id),
                            trailingActions: [
                              SwipeAction(
                                onTap: (CompletionHandler _) async {
                                  await _(true);
                                  await scController.delete(subCategory.id);
                                },
                                content: Container(
                                  color: Colors.red,
                                  height: 35,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "DELETE",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                color: Colors.white,
                              ),
                            ],
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                maxHeight: 80,
                              ),
                              child: Card(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      subCategory.name,
                                    ),
                                    Text(
                                      scController.getMainCategory(
                                        subCategory.parentId,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class UpDownChoice<T> extends StatelessWidget {
  const UpDownChoice({
    Key? key,
    required this.items,
    required this.hint,
    required this.increase,
    required this.decrease,
    required this.isEmpty,
    required this.selectedValue,
    required this.isError,
  }) : super(key: key);

  final List<T> items;
  final String selectedValue;
  final void Function() increase;
  final void Function() decrease;
  final String hint;
  final bool isEmpty;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 0,
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: isError ? Colors.red : Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            //Text
            Expanded(
              child: Text(isEmpty ? hint : selectedValue,
                  style: isEmpty
                      ? const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        )),
            ),
            /* SizedBox(
              height: 50,
              child: Column(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: decrease,
                      icon: const Icon(
                        FontAwesomeIcons.chevronUp,
                        size: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: increase,
                      icon: const Icon(
                        FontAwesomeIcons.chevronDown,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            ) */
            //Up & Down button
          ],
        ),
      ),
    );
  }
}
