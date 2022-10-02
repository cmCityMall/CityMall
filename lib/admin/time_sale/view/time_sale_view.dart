import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/admin/time_sale/controller/time_sale_controller.dart';
import 'package:citymall/admin/week_promotion/controller/week_promotion_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
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

class TimeSaleView extends StatelessWidget {
  const TimeSaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final TimeSaleController timeSaleController = Get.find();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Flash Sales",
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
              onPressed: () => timeSaleController.save(),
              child: const Text("Save"),
            ),
          )
        ],
      ),
      body: Obx(() {
        return Form(
          key: timeSaleController.formKey,
          autovalidateMode: timeSaleController.isFirstTimePressed.value
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
                    controller: timeSaleController.nameController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        timeSaleController.validate(value, "Name"),
                    labelText: "Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextForm(
                    padding: 0,
                    rightPadding: 0,
                    height: 85,
                    maxLines: 1,
                    textFieldPaddingLeft: 10,
                    controller: timeSaleController.descController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        timeSaleController.validate(value, "Description"),
                    labelText: "Description(eg-30% off)",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextForm(
                    padding: 0,
                    rightPadding: 0,
                    height: 85,
                    maxLines: 1,
                    keyboaType: TextInputType.number,
                    textFieldPaddingLeft: 10,
                    controller: timeSaleController.percentageController,
                    isUnderlineBorder: false,
                    validator: (value) => timeSaleController.validate(
                        value, "Discount percentage"),
                    labelText: "Discount percentage(eg-30)",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    final pickedImage = timeSaleController.pickedImage.value;
                    final isEmpty = pickedImage.isEmpty;
                    return ImagePickForm(
                      labelText: isEmpty ? "pick an image" : pickedImage,
                      pickImage: () => timeSaleController.pickImage(),
                    );
                  }),
                  Obx(() {
                    return timeSaleController.isFirstTimePressed.value &&
                            timeSaleController.pickedImage.isEmpty
                        ? const SizedBox(
                            height: 25,
                            child: Text("Image is required.",
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                          )
                        : const SizedBox();
                  }),
                  /**Advertisement List*/
                  Obx(
                    () {
                      if (dataController.timeSales.isEmpty) {
                        return const Center(
                            child: Text(
                          "No flash sales yet....",
                        ));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataController.timeSales.length,
                        itemBuilder: (context, index) {
                          var advertisement = dataController.timeSales[index];

                          return SwipeActionCell(
                            key: ValueKey(advertisement.id),
                            trailingActions: [
                              SwipeAction(
                                onTap: (CompletionHandler _) async {
                                  await _(true);
                                  await timeSaleController
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
                                  await timeSaleController
                                      .getProductsExceptCurrentTimeSale(
                                          advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      if (timeSaleController
                                          .addProductLoading.value) {
                                        return const Card(
                                            child: LoadingWidget());
                                      }
                                      if (timeSaleController
                                          .productList.isEmpty) {
                                        return const Card(
                                          child:
                                              EmptyWidget("No products found."),
                                        );
                                      }
                                      return SelectableBottomSheet(
                                        list: timeSaleController.productList,
                                        selectedObxMap: timeSaleController
                                            .selectedProductsMap,
                                        pressedCancelButton: () {
                                          timeSaleController.selectedProductsMap
                                              .clear();
                                          timeSaleController.productList
                                              .clear();
                                        },
                                        pressedSaveButton: () {
                                          timeSaleController
                                              .addProductsFromTimeSale(
                                            advertisement.id,
                                            advertisement.percentage ?? 0,
                                          );
                                        },
                                        selectedProduct: (p) {
                                          timeSaleController
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
                                  await timeSaleController
                                      .getProductsFromTimeSale(
                                          advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      final isLoading = timeSaleController
                                          .removeProductLoading.value;
                                      final selectedMap = timeSaleController
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
                                        list: timeSaleController
                                            .selectedProductsMap.entries
                                            .map((e) => e.value)
                                            .toList(),
                                        selectedObxMap: timeSaleController
                                            .removedProductsMap,
                                        pressedCancelButton: () {
                                          timeSaleController.removedProductsMap
                                              .clear();
                                          timeSaleController.selectedProductsMap
                                              .clear();
                                        },
                                        pressedSaveButton: () {},
                                        selectedProduct: (p) =>
                                            timeSaleController
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
                                        advertisement.desc ?? "",
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

class SelectableBottomSheet extends StatelessWidget {
  const SelectableBottomSheet({
    Key? key,
    required this.list,
    required this.selectedObxMap,
    required this.pressedCancelButton,
    required this.pressedSaveButton,
    required this.selectedProduct,
  }) : super(key: key);

  final List<Product> list;
  final RxMap<String, Product> selectedObxMap;
  final void Function(Product product) selectedProduct;
  final void Function() pressedCancelButton;
  final void Function() pressedSaveButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final product = list[index];

                return Obx(() {
                  final map = selectedObxMap;
                  final isSelected = map.containsKey(product.id);
                  return InkWell(
                    onTap: () => selectedProduct(product),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: isSelected ? Colors.green : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.name,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              )),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          SizedBox(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        pressedCancelButton();
                      },
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => pressedSaveButton(),
                      child: const Text("Save"),
                    ),
                  ])),
        ],
      ),
    );
  }
}
