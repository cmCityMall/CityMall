import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../colors/colors.dart';
import '../../../images/images.dart';
import '../../../widgets/form/color_picker.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/selected_bottom_sheet.dart';
import '../../../widgets/form/text_form.dart';
import '../../sub_category/view/sc_view.dart';
import '../controller/reward_product_controller.dart';

class UploadRewardProduct extends StatefulWidget {
  const UploadRewardProduct({Key? key}) : super(key: key);

  @override
  State<UploadRewardProduct> createState() => _UploadRewardProductState();
}

class _UploadRewardProductState extends State<UploadRewardProduct> {
  final RewardProductController productController = Get.find();
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
    final editProduct = dataController.editRewardProduct;
    final isEdit = !(editProduct == null);
    final isNew = dataController.editRewardProduct == null;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            "REWARD PRODUCT",
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
                style: ElevatedButton.styleFrom(
                  primary: ColorResources.blue1,
                ),
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
                      controller: productController.requiredPointController,
                      isUnderlineBorder: false,
                      validator: (value) =>
                          productController.validate(value, "Point"),
                      labelText: "Point",
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
                              "Pick image:",
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
                                          child: Card(
                                            child: !(productController
                                                    .isFile.value)
                                                ? CachedNetworkImage(
                                                    imageUrl: productController
                                                        .pickedImage.value,
                                                    memCacheHeight: 80,
                                                    memCacheWidth: 80,
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder:
                                                        (context, _, __) {
                                                      return Shimmer.fromColors(
                                                        highlightColor:
                                                            Colors.white,
                                                        baseColor: Colors.grey,
                                                        child: Container(
                                                            color:
                                                                Colors.white),
                                                      );
                                                    },
                                                  )
                                                : Card(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: Image.file(
                                                        File(productController
                                                            .pickedImage.value),
                                                        fit: BoxFit.cover,
                                                        height: 80,
                                                        width: 80,
                                                      ),
                                                    ),
                                                  ),
                                          ),
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

  final RewardProductController productController;

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
