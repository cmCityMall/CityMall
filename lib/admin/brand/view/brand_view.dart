import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../colors/colors.dart';
import '../../../utils/widgets/empty_widgt.dart';
import '../../../utils/widgets/loading_widget.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/selected_bottom_sheet.dart';
import '../../../widgets/form/text_form.dart';
import '../../selectable_bottom_sheet.dart';
import '../../sub_category/view/sc_view.dart';
import '../../week_promotion/view/week_promotion_view.dart';
import '../controller/brand_controller.dart';

class BrandView extends StatelessWidget {
  const BrandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.find();
    final DBDataController dataController = Get.find();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Brands",
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
              style: ElevatedButton.styleFrom(
                primary: ColorResources.blue1,
              ),
              onPressed: () => brandController.save(),
              child: const Text("Save"),
            ),
          )
        ],
      ),
      body: Obx(() {
        return Form(
          key: brandController.formKey,
          autovalidateMode: brandController.isFirstTimePressed.value
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
                    controller: brandController.nameController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        brandController.validate(value, "Name"),
                    labelText: "Brand Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Shop Id To Select
                  Obx(() {
                    return SelectedBottomSheet(
                      setSelectedId: (value) =>
                          brandController.setSelectedShopId(value),
                      setSelectedIdError: (value) =>
                          brandController.setSelectedShopIdError(value),
                      hint: "Select Shop",
                      isError: brandController.isFirstTimePressed.value &&
                          brandController.selectedShopId.isEmpty,
                      isEmpty: brandController.selectedShopId.isEmpty,
                      selectedValue: brandController.selectedShopId.value,
                      list:
                          brandController.shopList.map((e) => e.name).toList(),
                    );
                  }),
                  Obx(() {
                    return SizedBox(
                      height: 25,
                      child: Text(brandController.selectedShopIdError.value,
                          style: const TextStyle(
                            color: Colors.red,
                          )),
                    );
                  }),
                  Obx(() {
                    final pickedImage = brandController.pickedImage.value;
                    final isEmpty = pickedImage.isEmpty;
                    return ImagePickForm(
                      labelText: isEmpty ? "pick an image" : pickedImage,
                      pickImage: () => brandController.pickImage(),
                    );
                  }),
                  Obx(() {
                    return SizedBox(
                      height: 25,
                      child: Text(brandController.pickImageError.value,
                          style: const TextStyle(
                            color: Colors.red,
                          )),
                    );
                  }),

                  /**Advertisement List*/
                  Obx(
                    () {
                      if (brandController.brandList.isEmpty) {
                        return const Center(
                            child: Text(
                          "No brands yet....",
                        ));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: brandController.brandList.length,
                        itemBuilder: (context, index) {
                          var advertisement = brandController.brandList[index];

                          return SwipeActionCell(
                            key: ValueKey(advertisement.id),
                            trailingActions: [
                              SwipeAction(
                                onTap: (CompletionHandler _) async {
                                  await _(true);
                                  await brandController
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
                                  await brandController
                                      .getProductsExceptCurrentBrand(
                                          advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      if (brandController
                                          .addProductLoading.value) {
                                        return const Card(
                                            child: LoadingWidget());
                                      }
                                      if (brandController.productList.isEmpty) {
                                        return const Card(
                                          child:
                                              EmptyWidget("No products found."),
                                        );
                                      }
                                      return SelectableBottomSheet(
                                        list: brandController.productList,
                                        selectedObxMap:
                                            brandController.selectedProductsMap,
                                        pressedCancelButton: () {
                                          brandController.selectedProductsMap
                                              .clear();
                                          brandController.productList.clear();
                                        },
                                        pressedSaveButton: () {
                                          brandController.addProductsToBrand(
                                            advertisement.id,
                                          );
                                        },
                                        selectedProduct: (p) {
                                          brandController.selectProductOrNot(p);
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
                                  await brandController
                                      .getProductsWithBrandId(advertisement.id);
                                  Get.bottomSheet(
                                    Obx(() {
                                      final isLoading = brandController
                                          .removeProductLoading.value;
                                      final selectedMap =
                                          brandController.selectedProductsMap;
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
                                        list: brandController
                                            .selectedProductsMap.entries
                                            .map((e) => e.value)
                                            .toList(),
                                        selectedObxMap:
                                            brandController.removedProductsMap,
                                        pressedCancelButton: () {
                                          brandController.removedProductsMap
                                              .clear();
                                          brandController.selectedProductsMap
                                              .clear();
                                        },
                                        pressedSaveButton: () {},
                                        selectedProduct: (p) =>
                                            brandController.addIntoRemoveMap(p),
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
