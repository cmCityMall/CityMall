import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/admin/shop/controller/shop_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/widgets/empty_widgt.dart';
import '../../../utils/widgets/loading_widget.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/selected_bottom_sheet.dart';
import '../../../widgets/form/text_form.dart';
import '../../sub_category/view/sc_view.dart';
import '../../week_promotion/view/week_promotion_view.dart';

class ShopView extends StatelessWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Shops",
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
              onPressed: () => shopController.save(),
              child: const Text("Save"),
            ),
          )
        ],
      ),
      body: Obx(() {
        return Form(
          key: shopController.formKey,
          autovalidateMode: shopController.isFirstTimePressed.value
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
                    controller: shopController.nameController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        shopController.validate(value, "Name"),
                    labelText: "Shop Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    final pickedImage = shopController.pickedImage.value;
                    final isEmpty = pickedImage.isEmpty;
                    return ImagePickForm(
                      labelText: isEmpty ? "pick an image" : pickedImage,
                      pickImage: () => shopController.pickImage(),
                    );
                  }),
                  Obx(() {
                    return SizedBox(
                      height: 25,
                      child: Text(shopController.pickImageError.value,
                          style: const TextStyle(
                            color: Colors.red,
                          )),
                    );
                  }),

                  /**Advertisement List*/
                  Obx(
                    () {
                      if (shopController.shopList.isEmpty) {
                        return const Center(
                            child: Text(
                          "No shops yet....",
                        ));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shopController.shopList.length,
                        itemBuilder: (context, index) {
                          var advertisement = shopController.shopList[index];

                          return SwipeActionCell(
                            key: ValueKey(advertisement.id),
                            trailingActions: [
                              SwipeAction(
                                onTap: (CompletionHandler _) async {
                                  await _(true);
                                  await shopController.delete(advertisement.id);
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
                                  await shopController
                                      .getProductsExceptCurrentShop(
                                          advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      if (shopController
                                          .addProductLoading.value) {
                                        return const Card(
                                            child: LoadingWidget());
                                      }
                                      if (shopController.productList.isEmpty) {
                                        return const Card(
                                          child:
                                              EmptyWidget("No products found."),
                                        );
                                      }
                                      return SelectableBottomSheet(
                                        list: shopController.productList,
                                        selectedObxMap:
                                            shopController.selectedProductsMap,
                                        pressedCancelButton: () {
                                          shopController.selectedProductsMap
                                              .clear();
                                          shopController.productList.clear();
                                        },
                                        pressedSaveButton: () {
                                          shopController.addProductsToShop(
                                            advertisement.id,
                                          );
                                        },
                                        selectedProduct: (p) {
                                          shopController.selectProductOrNot(p);
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
                                  await shopController
                                      .getProductsFromShop(advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      final isLoading = shopController
                                          .removeProductLoading.value;
                                      final selectedMap =
                                          shopController.selectedProductsMap;
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
                                        list: shopController
                                            .selectedProductsMap.entries
                                            .map((e) => e.value)
                                            .toList(),
                                        selectedObxMap:
                                            shopController.removedProductsMap,
                                        pressedCancelButton: () {
                                          shopController.removedProductsMap
                                              .clear();
                                          shopController.selectedProductsMap
                                              .clear();
                                        },
                                        pressedSaveButton: () {},
                                        selectedProduct: (p) =>
                                            shopController.addIntoRemoveMap(p),
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
