import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../images/images.dart';
import '../../../widgets/form/color_picker.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/selected_bottom_sheet.dart';
import '../../../widgets/form/text_form.dart';
import '../../sub_category/view/sc_view.dart';
import '../controller/product_controller.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  final ProductController productController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    productController.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final editProduct = dataController.editProduct;
    final isEdit = !(editProduct == null);
    final isNew = dataController.editProduct == null;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            "PRODUCT",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              // fontStyle: FontStyle.italic,
              wordSpacing: 2,
              letterSpacing: 3,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                /* style: ElevatedButton.styleFrom(
                  primary: homeIndicatorColor,
                ), */
                child: isNew ? const Text("Save") : const Text("Edit"),
                onPressed: () => productController.save(),
              ),
            ),
          ],
          elevation: 5,
          //backgroundColor: detailBackgroundColor,
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Form(
            key: productController.formKey,
            autovalidateMode: productController.isFirstTimePressed.value
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const LoadingWidget();
                }
                return ListView(
                  children: [
                    const SizedBox(height: 20),
                    //Scan Bar Code
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          //Label
                          const Text(
                            "Scan bar code => ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          //Barcode image
                          InkWell(
                            onTap: () => productController.scanBarCode(),
                            child: Image.asset(
                              Images.barCode,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      final isError =
                          productController.isFirstTimePressed.value &&
                              productController.barCode.isEmpty;
                      return isError
                          ? const Text(
                              "Bar code is required.",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox();
                    }),
                    //Name
                    CustomTextForm(
                      padding: 0,
                      height: 85,
                      maxLines: 1,
                      textFieldPaddingLeft: 10,
                      controller: productController.nameController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          productController.validate(value, "Name"),
                      labelText: "Name",
                    ),
                    //Description
                    CustomTextForm(
                      padding: 0,
                      height: 85,
                      keyboaType: TextInputType.multiline,
                      textFieldPaddingLeft: 10,
                      controller: productController.descriptionController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          productController.validate(value, "Description"),
                      labelText: "Description",
                    ),

                    //Price
                    CustomTextForm(
                      padding: 0,
                      height: 85,
                      textFieldPaddingLeft: 10,
                      keyboaType: TextInputType.number,
                      controller: productController.priceController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          productController.validate(value, "Price"),
                      labelText: "Price",
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    //Total Quantity
                    CustomTextForm(
                      padding: 0,
                      height: 85,
                      textFieldPaddingLeft: 10,
                      keyboaType: TextInputType.number,
                      controller: productController.totalQuantityController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          productController.validate(value, "Total Quantity"),
                      labelText: "Total Quantity",
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    //Remain Quantity
                    CustomTextForm(
                      padding: 0,
                      height: 85,
                      textFieldPaddingLeft: 10,
                      keyboaType: TextInputType.number,
                      controller: productController.remainQuantityController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          productController.validate(value, "Remain Quantity"),
                      labelText: "Remain Quantity",
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    //Main Category
                    Text(
                      "Category:",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return SelectedBottomSheet(
                        isError: productController.isFirstTimePressed.value &&
                            productController.selectedMainCategoryId.isEmpty,
                        setSelectedId: (value) =>
                            productController.setSelectedMainCategoryId(value),
                        setSelectedIdError: (value) => productController
                            .setSelectedMainCategoryIdError(value),
                        hint: "Select Main Category",
                        isEmpty:
                            productController.selectedMainCategoryId.isEmpty,
                        selectedValue:
                            productController.selectedMainCategoryId.value,
                        list: productController.mainCategories
                            .map((e) => e.name)
                            .toList(),
                      );
                    }),
                    Obx(() {
                      final isError =
                          productController.selectedMainCategoryIdError.value;
                      return isError.isNotEmpty
                          ? const Text(
                              "Main Category is required.",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox();
                    }),
                    const SizedBox(height: 10),
                    //Sub Category
                    Obx(() {
                      final subCategories = productController.subCategories;
                      final isEmpty = subCategories.isEmpty;
                      debugPrint("*******ISEMpty: $isEmpty");
                      if (isEmpty) {
                        return const SizedBox();
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Text(
                            "Sub Category:",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 10),
                          SelectedBottomSheet(
                            isError: productController
                                    .isFirstTimePressed.value &&
                                productController.selectedSubCategoryId.isEmpty,
                            setSelectedId: (value) => productController
                                .setSelectedSubCategoryId(value),
                            setSelectedIdError: (value) => productController
                                .setSelectedSubCategoryIdError(value),
                            hint: "Select Sub Category",
                            isEmpty:
                                productController.selectedSubCategoryId.isEmpty,
                            selectedValue:
                                productController.selectedSubCategoryId.value,
                            list: productController.subCategories
                                .map((e) => e.name)
                                .toList(),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 10),
                    //Brand Id
                    Text(
                      "Brand:",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return SelectedBottomSheet(
                        isError: productController.isFirstTimePressed.value &&
                            productController.selectedBrandId.isEmpty,
                        setSelectedId: (value) =>
                            productController.setSelectedBrandId(value),
                        setSelectedIdError: (value) =>
                            productController.setSelectedBrandIdError(value),
                        hint: "Select a brand",
                        isEmpty:
                            productController.selectedBrandId.value.isEmpty,
                        selectedValue: productController.selectedBrandId.value,
                        list: productController.brands
                            .map((element) => element.name)
                            .toList(),
                      );
                    }),
                    const SizedBox(height: 10),
                    //Shop Id
                    Text(
                      "Shop:",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return SelectedBottomSheet(
                        isError: productController.isFirstTimePressed.value &&
                            productController.selectedShopId.isEmpty,
                        setSelectedId: (value) =>
                            productController.setSelectedShopId(value),
                        setSelectedIdError: (value) =>
                            productController.setSelectedShopIdError(value),
                        hint: "Select a shop",
                        isEmpty: productController.selectedShopId.value.isEmpty,
                        selectedValue: productController.selectedShopId.value,
                        list: productController.shops
                            .map((element) => element.name)
                            .toList(),
                      );
                    }),
                    const SizedBox(height: 10),
                    //Promotion
                    Text(
                      "Promotion:",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return SelectedBottomSheet(
                        isError: productController.isFirstTimePressed.value &&
                            productController.selectedPromotionId.isEmpty,
                        setSelectedId: (value) =>
                            productController.setSelectedPromotionId(value),
                        setSelectedIdError: (value) => productController
                            .setSelectedPromotionIdError(value),
                        hint: "Select a promotion",
                        isEmpty:
                            productController.selectedPromotionId.value.isEmpty,
                        selectedValue:
                            productController.selectedPromotionId.value,
                        list: dataController.weekPromotions
                            .map((element) => element.desc)
                            .toList(),
                      );
                    }),
                    const SizedBox(height: 10),
                    //COLOR,IMAGE,SIZE,PRICE
                    SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          Text(
                            "color,image,size and price:",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () =>
                                productController.addColorImagePriceSize(),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      final map = productController.colorImagePriceSize;
                      return map.isNotEmpty
                          ? ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: map.entries.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.black,
                                    )),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        //Color
                                        ColorPickerForm(
                                          labelText: "Pick Color",
                                          leftPadding: 10,
                                          radius: 20,
                                          selectedColor: e.value.color,
                                          onColorChanged: (value) =>
                                              productController.changeSizeColor(
                                                  e.key, value),
                                        ),
                                        //Image
                                        ImagePickForm(
                                          labelText: e.value.image.isEmpty
                                              ? "pick an image"
                                              : e.value.image,
                                          pickImage: () => productController
                                              .pickSizeImage(e.key),
                                        ),

                                        //Price
                                        CustomTextForm(
                                          padding: 0,
                                          height: 85,
                                          maxLines: 1,
                                          textFieldPaddingLeft: 10,
                                          controller: e.value.price,
                                          isUnderlineBorder: false,
                                          validator: (value) =>
                                              productController.validate(
                                                  value, "Price"),
                                          labelText: "Price",
                                        ),
                                        //Size
                                        CustomTextForm(
                                          padding: 0,
                                          maxLines: 1,
                                          textFieldPaddingLeft: 10,
                                          controller: e.value.size,
                                          isUnderlineBorder: false,
                                          validator: (value) =>
                                              productController.validate(
                                                  value, "Size"),
                                          labelText: "Size(eg-X,M,L)",
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: IconButton(
                                              onPressed: () => productController
                                                  .removeColorImagePriceSize(
                                                      e.key),
                                              icon: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : const SizedBox();
                    }),
                    const SizedBox(height: 20),
                    //Main Images PIck
                    Obx(() {
                      final isError =
                          productController.isFirstTimePressed.value &&
                              productController.pickedImage.isEmpty;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isError ? Colors.red : Colors.white),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              "Pick images:",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(height: 10),
                            //Images
                            Obx(
                              () {
                                return productController.pickedImage.isEmpty
                                    ? Align(
                                        alignment: Alignment.bottomLeft,
                                        child: AddImage(
                                            productController:
                                                productController))
                                    : Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: List.generate(
                                                  productController
                                                          .pickedImage.length +
                                                      1, (index) {
                                                if (index ==
                                                    productController
                                                        .pickedImage.length) {
                                                  return AddImage(
                                                      productController:
                                                          productController);
                                                }
                                                final element =
                                                    productController
                                                        .pickedImage[index];
                                                return Card(
                                                  child: !(productController
                                                          .isFile.value)
                                                      ? CachedNetworkImage(
                                                          imageUrl: element,
                                                          memCacheHeight: 80,
                                                          memCacheWidth: 80,
                                                          fit: BoxFit.cover,
                                                          progressIndicatorBuilder:
                                                              (context, _, __) {
                                                            return Shimmer
                                                                .fromColors(
                                                              highlightColor:
                                                                  Colors.white,
                                                              baseColor:
                                                                  Colors.grey,
                                                              child: Container(
                                                                  color: Colors
                                                                      .white),
                                                            );
                                                          },
                                                        )
                                                      : Card(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            20)),
                                                            child: Image.file(
                                                              File(element),
                                                              fit: BoxFit.cover,
                                                              height: 80,
                                                              width: 80,
                                                            ),
                                                          ),
                                                        ),
                                                );
                                              })),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),
            )));
  }
}

class AddImage extends StatelessWidget {
  const AddImage({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Card(
        child: InkWell(
            onTap: () => productController.pickImage(),
            child: SvgPicture.asset(
              Images.addImageIcon,
              width: 80,
              height: 80,
            )),
      ),
    );
  }
}
