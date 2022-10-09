import 'dart:io';

import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/addnewcardscreen.dart';
import 'package:citymall/productdetailsscreen/confirmaddressscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      appBar: AppBar(
        backgroundColor: themeController.isLightTheme.value
            ? ColorResources.white
            : ColorResources.black4,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 13,
                    color: ColorResources.blue1.withOpacity(0.3),
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: ColorResources.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose your payment\nmethod",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 24,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black2
                                  : ColorResources.white,
                            ),
                          ),
                          //CashOnDelivery
                          Obx(() {
                            return InkWell(
                              onTap: () {
                                cartController.setSelectedPaymentIndex(0);
                              },
                              child: Container(
                                // ignore: sort_child_properties_last
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              color: ColorResources.black11,
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    Images.cashondeliver),
                                              ),
                                            ),
                                          ),
                                          // ignore: prefer_const_constructors
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Cash On Delivery",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 14,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          36 /*MediaQuery.of(context).size.height/24.75*/ /*36*/,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        color: cartController
                                                    .selectedPaymentIndex
                                                    .value ==
                                                0
                                            ? ColorResources.blue1
                                            : ColorResources.blue1
                                                .withOpacity(0.06),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: cartController
                                                      .selectedPaymentIndex
                                                      .value ==
                                                  0
                                              ? Colors.transparent
                                              : ColorResources.blue1,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: cartController
                                                    .selectedPaymentIndex
                                                    .value ==
                                                0
                                            ? ColorResources.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height /
                                    12.72 /*70*/,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        25.45 /*35*/),
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        52.41 /*17*/,
                                    bottom: MediaQuery.of(context).size.height /
                                        52.41 /*17*/,
                                    left: 24,
                                    right: 24),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.white
                                      : ColorResources.black4,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: cartController
                                                .selectedPaymentIndex.value ==
                                            0
                                        ? ColorResources.blue1
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                              ),
                            );
                          }),
                          //Prepay => Bank,Wave ScreenShot
                          Obx(() {
                            return InkWell(
                              onTap: () {
                                cartController.setSelectedPaymentIndex(1);
                              },
                              child: Container(
                                // ignore: sort_child_properties_last
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              color: ColorResources.black11,
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              image: const DecorationImage(
                                                image: AssetImage(Images.card),
                                              ),
                                            ),
                                          ),
                                          // ignore: prefer_const_constructors
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Prepay",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 14,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          36 /*MediaQuery.of(context).size.height/24.75*/ /*36*/,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        color: cartController
                                                    .selectedPaymentIndex
                                                    .value ==
                                                1
                                            ? ColorResources.blue1
                                            : ColorResources.blue1
                                                .withOpacity(0.06),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: cartController
                                                      .selectedPaymentIndex
                                                      .value ==
                                                  1
                                              ? Colors.transparent
                                              : ColorResources.blue1,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: cartController
                                                    .selectedPaymentIndex
                                                    .value ==
                                                1
                                            ? ColorResources.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height /
                                    12.72 /*70*/,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        25.45 /*35*/),
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        52.41 /*17*/,
                                    bottom: MediaQuery.of(context).size.height /
                                        52.41 /*17*/,
                                    left: 24,
                                    right: 24),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.white
                                      : ColorResources.black4,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: cartController
                                                .selectedPaymentIndex.value ==
                                            1
                                        ? ColorResources.blue1
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                              ),
                            );
                          }),
                          //If prepay we ask user to
                          //pick screenshot
                          Obx(() {
                            if (cartController.selectedPaymentIndex.value !=
                                1) {
                              return const SizedBox();
                            }
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Choose Screenshot button
                                  Center(
                                    child: OutlinedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      )),
                                      onPressed: () =>
                                          cartController.getPaidScreenShot(),
                                      child: const Text(
                                          "Choose KBZ / AYA / WAVE Screenshot"),
                                    ),
                                  ),
                                  //ScreenShotImage
                                  Obx(() {
                                    final image = cartController
                                        .paidScreenShotImage.value;
                                    if (image.isEmpty) {
                                      return const SizedBox();
                                    }
                                    return Image.file(
                                      File(image),
                                      fit: BoxFit.cover,
                                      width: 200,
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                        ]),
                  )),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "",
                      titlePadding: EdgeInsets.zero,
                      content: const PaymentSuccessDialogWidget(),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: ColorResources.blue1,
                    ),
                    child: const Center(
                      child: Text(
                        "Pay",
                        style: TextStyle(
                          fontFamily: TextFontFamily.SEN_BOLD,
                          fontSize: 20,
                          color: ColorResources.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSuccessDialogWidget extends StatelessWidget {
  const PaymentSuccessDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Images.paymentSuccess, height: 120, width: 120),
        SizedBox(height: 20),
        Text(
          "Yuppy!!",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 27,
            color: ColorResources.black2,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Your Payment Recive to Seller",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 14,
            color: ColorResources.black,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
