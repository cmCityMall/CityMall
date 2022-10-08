import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/widgets/empty_widgt.dart';
import '../../../utils/widgets/loading_widget.dart';
import '../../../widgets/form/custon_swich.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/text_form.dart';
import '../../selectable_bottom_sheet.dart';
import '../controller/mc_controller.dart';

class MCView extends StatelessWidget {
  const MCView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MCController mcController = Get.find();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Center(
              child: Text(
            "Main Categories",
            style: TextStyle(
              color: Colors.black,
            ),
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () => mcController.save(),
                child: const Text("Save"),
              ),
            )
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
                key: mcController.formKey,
                autovalidateMode: mcController.isFirstTimePressed.value
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
                        controller: mcController.nameController,
                        isUnderlineBorder: false,
                        validator: mcController.validate,
                        labelText: "Ad Name",
                      ),
                      Obx(() {
                        final pickedImage = mcController.pickedImage.value;
                        final isEmpty = pickedImage.isEmpty;
                        return ImagePickForm(
                          labelText: isEmpty ? "pick an image" : pickedImage,
                          pickImage: () => mcController.pickImage(),
                        );
                      }),
                      //ImagePickFormError
                      Obx(() {
                        return mcController.isFirstTimePressed.value &&
                                mcController.pickedImage.isEmpty
                            ? const Text("Image is required.",
                                style: TextStyle(
                                  color: Colors.red,
                                ))
                            : const SizedBox();
                      }),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("MenuBar"),
                                const SizedBox(height: 5),
                                Obx(() {
                                  final isHot = mcController.isMenu.value;
                                  return CustomSwitch(
                                    value: isHot,
                                    onChanged: (value) =>
                                        mcController.changeIsMenu(value),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      /**Advertisement List*/
                      Expanded(
                        child: Obx(
                          () {
                            if (mcController.mainCategories.isEmpty) {
                              return const Center(
                                  child: Text(
                                "No main categories yet....",
                              ));
                            }

                            return ListView.builder(
                              itemCount: mcController.mainCategories.length,
                              itemBuilder: (context, index) {
                                var advertisement =
                                    mcController.mainCategories[index];

                                return SwipeActionCell(
                                  key: ValueKey(advertisement.id),
                                  trailingActions: [
                                    SwipeAction(
                                      onTap: (CompletionHandler _) async {
                                        await _(true);
                                        await mcController
                                            .delete(advertisement.id);
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
                                    //Add Product
                                    SwipeAction(
                                      onTap: (CompletionHandler _) async {
                                        await _(false);
                                        await mcController.getSubCategoryAll(
                                            advertisement.id);
                                        Get.bottomSheet(
                                          Obx(() {
                                            if (mcController
                                                .addSubCategoryLoading.value) {
                                              return const Card(
                                                  child: LoadingWidget());
                                            }
                                            if (mcController
                                                .subCategoryList.isEmpty) {
                                              return const Card(
                                                child: EmptyWidget(
                                                    "No sub category found."),
                                              );
                                            }
                                            return SelectableSubCategoriesBottomSheet(
                                              list:
                                                  mcController.subCategoryList,
                                              selectedObxMap: mcController
                                                  .selectedSubCategorysMap,
                                              pressedCancelButton: () {
                                                mcController
                                                    .selectedSubCategorysMap
                                                    .clear();
                                                mcController
                                                    .removedSubCategorysMap
                                                    .clear();
                                              },
                                              pressedSaveButton: () =>
                                                  mcController
                                                      .addSubCategoryToMain(
                                                          advertisement.id),
                                              selectedSubCategory: (s) =>
                                                  mcController
                                                      .selectSubOrNot(s),
                                            );
                                          }),
                                          isDismissible: false,
                                        );
                                      },
                                      content: Container(
                                        color: Colors.green,
                                        height: 50,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "  Add\nub categories",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                    //Remove Product
                                    SwipeAction(
                                      onTap: (CompletionHandler _) async {
                                        await _(false);
                                        await mcController
                                            .getSubCategoryFromMain(
                                                advertisement.id);
                                        Get.bottomSheet(
                                          Obx(() {
                                            final isLoading = mcController
                                                .removeSubCategoryLoading.value;
                                            final selectedMap = mcController
                                                .removedSubCategorysMap;
                                            if (isLoading) {
                                              return const Card(
                                                  child: LoadingWidget());
                                            }
                                            if (selectedMap.isEmpty) {
                                              return const Card(
                                                child: EmptyWidget(
                                                    "No sub categories found."),
                                              );
                                            }
                                            return SelectableSubCategoriesBottomSheet(
                                              list: mcController
                                                  .removedSubCategorysMap
                                                  .entries
                                                  .map((e) => e.value)
                                                  .toList(),
                                              selectedObxMap: mcController
                                                  .selectedSubCategorysMap,
                                              pressedCancelButton: () {
                                                mcController
                                                    .selectedSubCategorysMap
                                                    .clear();
                                                mcController
                                                    .removedSubCategorysMap
                                                    .clear();
                                              },
                                              pressedSaveButton: () => mcController
                                                  .removeSubCategoriesFromMain(),
                                              selectedSubCategory: (s) =>
                                                  mcController
                                                      .selectSubOrNot(s),
                                            );
                                          }),
                                          isDismissible: false,
                                        );
                                      },
                                      content: Container(
                                        color: Colors.amber,
                                        height: 50,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "  Remove\nsub categories",
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
                                      maxHeight: 100,
                                    ),
                                    child: Card(
                                      child: Row(
                                        children: [
                                          //Advertisement IMAGE
                                          Expanded(
                                            child: CachedNetworkImage(
                                              progressIndicatorBuilder:
                                                  (context, url, status) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, whatever) {
                                                return const Text(
                                                    "Image not available");
                                              },
                                              imageUrl: advertisement.image,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          //Type
                                          Expanded(
                                            child: Text(
                                              advertisement.name,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ]),
              );
            })));
  }
}
