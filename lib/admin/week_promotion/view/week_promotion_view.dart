import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/admin/week_promotion/controller/week_promotion_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/week_promotion.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:citymall/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/product.dart';
import '../../../widgets/form/custon_swich.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/text_form.dart';
import '../../selectable_bottom_sheet.dart';

class WeekPromotionView extends StatelessWidget {
  const WeekPromotionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final WeekPromotionController weekPromotionController = Get.find();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Week Promotions",
          style: TextStyle(
            color: Colors.black,
          ),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
            ),
            child: ElevatedButton(
              onPressed: () => weekPromotionController.save(),
              child: const Text("Save"),
            ),
          )
        ],
      ),
      body: Obx(() {
        return Form(
          key: weekPromotionController.formKey,
          autovalidateMode: weekPromotionController.isFirstTimePressed.value
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /**Form*/
                  CustomTextForm(
                    padding: 0,
                    rightPadding: 0,
                    height: 85,
                    maxLines: 1,
                    textFieldPaddingLeft: 10,
                    controller: weekPromotionController.nameController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        weekPromotionController.validate(value, "Name"),
                    labelText: "Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return CustomTextForm(
                      padding: 0,
                      rightPadding: 0,
                      height: 85,
                      maxLines: 1,
                      maxLength:
                          weekPromotionController.isPercentage.value ? 3 : null,
                      textFieldPaddingLeft: 10,
                      controller: weekPromotionController.promoController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          weekPromotionController.validate(value, "Promotion"),
                      labelText: "Promotion",
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    final pickedImage =
                        weekPromotionController.pickedImage.value;
                    final isEmpty = pickedImage.isEmpty;
                    return ImagePickForm(
                      labelText: isEmpty ? "pick an image" : pickedImage,
                      pickImage: () => weekPromotionController.pickImage(),
                    );
                  }),
                  Obx(() {
                    return SizedBox(
                      height: 25,
                      child: Text(weekPromotionController.pickImageError.value,
                          style: const TextStyle(
                            color: Colors.red,
                          )),
                    );
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
                            const Text("Percentage"),
                            const SizedBox(height: 5),
                            Obx(() {
                              final isHot =
                                  weekPromotionController.isPercentage.value;
                              return CustomSwitch(
                                value: isHot,
                                onChanged: (value) => weekPromotionController
                                    .changeIsPercentage(),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  /**Advertisement List*/
                  Obx(
                    () {
                      if (dataController.weekPromotions.isEmpty) {
                        return const Center(
                            child: Text(
                          "No week promotions yet....",
                        ));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataController.weekPromotions.length,
                        itemBuilder: (context, index) {
                          var advertisement =
                              dataController.weekPromotions[index];

                          return SwipeActionCell(
                            key: ValueKey(advertisement.id),
                            trailingActions: [
                              SwipeAction(
                                onTap: (CompletionHandler _) async {
                                  await _(true);
                                  await weekPromotionController
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
                                  await weekPromotionController
                                      .getProductsExceptCurrentPromotion(
                                          advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      if (weekPromotionController
                                          .addProductLoading.value) {
                                        return const Card(
                                            child: LoadingWidget());
                                      }
                                      if (weekPromotionController
                                          .productList.isEmpty) {
                                        return const Card(
                                          child:
                                              EmptyWidget("No products found."),
                                        );
                                      }
                                      return SelectableBottomSheet(
                                        list:
                                            weekPromotionController.productList,
                                        selectedObxMap: weekPromotionController
                                            .selectedProductsMap,
                                        pressedCancelButton: () {
                                          weekPromotionController
                                              .selectedProductsMap
                                              .clear();
                                          weekPromotionController.productList
                                              .clear();
                                        },
                                        pressedSaveButton: () {
                                          weekPromotionController
                                              .addProductsToPromotion(
                                            advertisement.id,
                                            advertisement.percentage ?? 0,
                                          );
                                        },
                                        selectedProduct: (p) {
                                          weekPromotionController
                                              .selectProductOrNot(p);
                                        },
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
                                      "  Add\nproducts",
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
                                  await weekPromotionController
                                      .getProductsFromPromotion(
                                          advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      final isLoading = weekPromotionController
                                          .removeProductLoading.value;
                                      final selectedMap =
                                          weekPromotionController
                                              .selectedProductsMap;
                                      if (isLoading) {
                                        return const Card(
                                            child: LoadingWidget());
                                      }
                                      if (selectedMap.isEmpty) {
                                        return const Card(
                                          child:
                                              EmptyWidget("No products found."),
                                        );
                                      }
                                      return SelectableBottomSheet(
                                        list: weekPromotionController
                                            .selectedProductsMap.entries
                                            .map((e) => e.value)
                                            .toList(),
                                        selectedObxMap: weekPromotionController
                                            .removedProductsMap,
                                        pressedCancelButton: () {
                                          weekPromotionController
                                              .removedProductsMap
                                              .clear();
                                          weekPromotionController
                                              .selectedProductsMap
                                              .clear();
                                        },
                                        pressedSaveButton: () {},
                                        selectedProduct: (p) =>
                                            weekPromotionController
                                                .addIntoRemoveMap(p),
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
                                      "  Remove\nproducts",
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
                                        errorWidget: (context, url, whatever) {
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
                                        advertisement.desc,
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
