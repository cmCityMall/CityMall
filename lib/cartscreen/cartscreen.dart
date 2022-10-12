import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/cart_controller.dart';
import 'package:citymall/controller/cartcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:citymall/widgets/cart/division_dialog_widget.dart';
import 'package:citymall/widgets/other/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/clickcontroller.dart';
import '../widgets/other/related_address_widget.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 140),
                child: Obx(() {
                  final map = cartController.cartMap;
                  if (map.isEmpty) {
                    return const EmptyWidget("Cart is empty.");
                  }
                  return ListView(
                    children: map.entries.map((e) {
                      final product = e.value;
                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorResources.white6,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: CustomCacheNetworkImage(
                                  imageUrl: e.value.image,
                                  boxFit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    product.name,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${product.color ?? ""},${product.size ?? ""}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.white7
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  "${product.lastPrice}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontWeight: FontWeight.w800,
                                    color: ColorResources.blue1,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                //Increase
                                IconButton(
                                  onPressed: () =>
                                      cartController.addIntoCart(product),
                                  icon: Container(
                                    decoration: const BoxDecoration(
                                        color: ColorResources.blue1,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        )),
                                    child: const Icon(
                                      Icons.add,
                                      color: ColorResources.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                //Count Text
                                Text(
                                  "${product.count}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    color: ColorResources.black,
                                  ),
                                ),
                                //Decrease
                                IconButton(
                                  onPressed: () =>
                                      cartController.removeFromCart(product.id),
                                  icon: Container(
                                    decoration: const BoxDecoration(
                                        color: ColorResources.blue1,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        )),
                                    child: const Icon(
                                      Icons.remove,
                                      color: ColorResources.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
              Positioned(
                bottom: 70,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2.withOpacity(0.6)
                                : ColorResources.white.withOpacity(0.6),
                          ),
                        ),
                        Obx(() {
                          return Text(
                            "${cartController.subTotal.value}MMK",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: TextFontFamily.SEN_BOLD,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black2
                                  : ColorResources.white,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //DropDown TownShip List
                        Container(
                          width: 250,
                          height: 50,
                          child:
                              GetBuilder<CartController>(builder: (controller) {
                            return InkWell(
                              onTap: () {
                                //Show Dialog
                                showDialog(
                                    barrierColor: Colors.white.withOpacity(0),
                                    context: context,
                                    builder: (context) {
                                      return const DivisionDialogWidget();
                                    });
                              },
                              child: Row(children: [
                                //Township Name
                                Expanded(
                                  child: Text(
                                    controller.townShipNameAndFee["townName"] ??
                                        "မြို့နယ်",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                              .withOpacity(0.6)
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                //DropDown Icon
                                const Expanded(
                                    child: Icon(FontAwesomeIcons.angleRight)),
                              ]),
                            );
                          }),
                        ),
                        GetBuilder<CartController>(builder: (controller) {
                          return Row(
                            children: [
                              Text(
                                controller.townShipNameAndFee.isEmpty
                                    ? "0 MMK"
                                    : " ${controller.townShipNameAndFee["fee"]} MMK",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black4,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: ColorResources.black.withOpacity(0.05),
                            spreadRadius: 0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GetBuilder<CartController>(builder: (controller) {
                              return Obx(() {
                                return Text(
                                  controller.townShipNameAndFee.isEmpty
                                      ? "${controller.subTotal.value}"
                                      : "${controller.subTotal.value + controller.townShipNameAndFee["fee"]}MMK",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                );
                              });
                            }),
                            GetBuilder<CartController>(builder: (controller) {
                              final deliveryEmpty =
                                  cartController.townShipNameAndFee.isNotEmpty;
                              return Obx(() {
                                return InkWell(
                                  onTap: (cartController.subTotal.value > 0 &&
                                          deliveryEmpty)
                                      ? () {
                                          Get.bottomSheet(
                                            Container(
                                              child: RelatedAddressWidget(
                                                themeController:
                                                    themeController,
                                              ),
                                            ),
                                            backgroundColor: themeController
                                                    .isLightTheme.value
                                                ? ColorResources.white
                                                : ColorResources.black4,
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: ColorResources.blue1,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "PAY",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          color: ColorResources.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
