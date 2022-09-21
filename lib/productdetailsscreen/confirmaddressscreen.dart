import 'package:dotted_line/dotted_line.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/addaddressscreen.dart';
import 'package:citymall/productdetailsscreen/paymentscreen.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ConfirmAddressScreen extends StatelessWidget {
  ConfirmAddressScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final AddressClickController1 addressClickController1 =
      Get.put(AddressClickController1());
  List<Map> bottomAddressList = [
    {
      "icon": Images.homefill,
      "text1": "Home Address",
      "text2": "+91 12345 67890",
    },
    {
      "icon": Images.office,
      "text1": "Office Address",
      "text2": "+91 98765 43210",
    },
  ];

  Row row(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 15,
            color: themeController.isLightTheme.value
                ? ColorResources.grey4
                : ColorResources.white.withOpacity(0.6),
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 15,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Get.off(ProductDetailScreen());
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
              child: Center(
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
          "Details",
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Address",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_BOLD,
                                fontSize: 16,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: Get.width,
                                            color: themeController
                                                    .isLightTheme.value
                                                ? ColorResources.white11
                                                : ColorResources.black1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Saved Address",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: TextFontFamily
                                                          .SEN_BOLD,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? ColorResources
                                                              .black2
                                                          : ColorResources
                                                              .white,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.off(
                                                          AddAddressScreen());
                                                    },
                                                    child: Text(
                                                      "Add New Address",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            TextFontFamily
                                                                .SEN_BOLD,
                                                        color: ColorResources
                                                            .blue1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => InkWell(
                                              onTap: () {
                                                if (addressClickController1
                                                        .one.isTrue ||
                                                    addressClickController1
                                                        .two.isTrue) {
                                                  addressClickController1
                                                      .one(false);
                                                  addressClickController1
                                                      .two(false);
                                                }
                                                addressClickController1
                                                    .one(true);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20),
                                                child: Container(
                                                  height: 165,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: themeController
                                                            .isLightTheme.value
                                                        ? addressClickController1
                                                                .one.isTrue
                                                            ? ColorResources
                                                                .lightgreen
                                                            : ColorResources
                                                                .white
                                                        : addressClickController1
                                                                .one.isTrue
                                                            ? ColorResources
                                                                .black6
                                                            : ColorResources
                                                                .black6,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? addressClickController1
                                                                  .one.isTrue
                                                              ? ColorResources
                                                                  .green1
                                                              : ColorResources
                                                                  .grey11
                                                          : addressClickController1
                                                                  .one.isTrue
                                                              ? ColorResources
                                                                  .blue1
                                                              : ColorResources
                                                                  .black5,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              Images.homefill,
                                                              height: 15,
                                                              width: 15,
                                                              color: themeController
                                                                      .isLightTheme
                                                                      .value
                                                                  ? addressClickController1
                                                                          .one
                                                                          .isTrue
                                                                      ? ColorResources
                                                                          .green1
                                                                      : ColorResources
                                                                          .black2
                                                                  : addressClickController1
                                                                          .one
                                                                          .isTrue
                                                                      ? ColorResources
                                                                          .blue1
                                                                      : ColorResources
                                                                          .white,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Home Address",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    TextFontFamily
                                                                        .SEN_BOLD,
                                                                color: themeController
                                                                        .isLightTheme
                                                                        .value
                                                                    ? addressClickController1
                                                                            .one
                                                                            .isTrue
                                                                        ? ColorResources
                                                                            .green1
                                                                        : ColorResources
                                                                            .black2
                                                                    : addressClickController1
                                                                            .one
                                                                            .isTrue
                                                                        ? ColorResources
                                                                            .blue1
                                                                        : ColorResources
                                                                            .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          " John Doe",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_BOLD,
                                                            color: themeController
                                                                    .isLightTheme
                                                                    .value
                                                                ? addressClickController1
                                                                        .one
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .black2
                                                                    : ColorResources
                                                                        .black2
                                                                : addressClickController1
                                                                        .one
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .white
                                                                    : ColorResources
                                                                        .white,
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                          "+91 12345 67890",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_REGULAR,
                                                            color: themeController
                                                                    .isLightTheme
                                                                    .value
                                                                ? addressClickController1
                                                                        .one
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .black2
                                                                    : ColorResources
                                                                        .black2
                                                                : addressClickController1
                                                                        .one
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .white
                                                                    : ColorResources
                                                                        .white,
                                                          ),
                                                        ),
                                                        SizedBox(height: 12),
                                                        Text(
                                                          "Building No,66, 78th Main Road, 100ft\nRoad, Indiranagar, Bangalore 123456",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_REGULAR,
                                                            color: themeController
                                                                    .isLightTheme
                                                                    .value
                                                                ? addressClickController1
                                                                        .one
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .black9
                                                                    : ColorResources
                                                                        .black9
                                                                : addressClickController1
                                                                        .one
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6)
                                                                    : ColorResources
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Obx(
                                            () => InkWell(
                                              onTap: () {
                                                if (addressClickController1
                                                        .one.isTrue ||
                                                    addressClickController1
                                                        .two.isTrue) {
                                                  addressClickController1
                                                      .one(false);
                                                  addressClickController1
                                                      .two(false);
                                                }
                                                addressClickController1
                                                    .two(true);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Container(
                                                  height: 165,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: themeController
                                                            .isLightTheme.value
                                                        ? addressClickController1
                                                                .two.isTrue
                                                            ? ColorResources
                                                                .lightgreen
                                                            : ColorResources
                                                                .white
                                                        : addressClickController1
                                                                .two.isTrue
                                                            ? ColorResources
                                                                .black6
                                                            : ColorResources
                                                                .black6,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? addressClickController1
                                                                  .two.isTrue
                                                              ? ColorResources
                                                                  .green1
                                                              : ColorResources
                                                                  .grey11
                                                          : addressClickController1
                                                                  .two.isTrue
                                                              ? ColorResources
                                                                  .blue1
                                                              : ColorResources
                                                                  .black5,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              Images.office,
                                                              height: 15,
                                                              width: 15,
                                                              color: themeController
                                                                      .isLightTheme
                                                                      .value
                                                                  ? addressClickController1
                                                                          .two
                                                                          .isTrue
                                                                      ? ColorResources
                                                                          .green1
                                                                      : ColorResources
                                                                          .black2
                                                                  : addressClickController1
                                                                          .two
                                                                          .isTrue
                                                                      ? ColorResources
                                                                          .blue1
                                                                      : ColorResources
                                                                          .white,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Office Address",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    TextFontFamily
                                                                        .SEN_BOLD,
                                                                color: themeController
                                                                        .isLightTheme
                                                                        .value
                                                                    ? addressClickController1
                                                                            .two
                                                                            .isTrue
                                                                        ? ColorResources
                                                                            .green1
                                                                        : ColorResources
                                                                            .black2
                                                                    : addressClickController1
                                                                            .two
                                                                            .isTrue
                                                                        ? ColorResources
                                                                            .blue1
                                                                        : ColorResources
                                                                            .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          " John Doe",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_BOLD,
                                                            color: themeController
                                                                    .isLightTheme
                                                                    .value
                                                                ? addressClickController1
                                                                        .two
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .black2
                                                                    : ColorResources
                                                                        .black2
                                                                : addressClickController1
                                                                        .two
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .white
                                                                    : ColorResources
                                                                        .white,
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                          "+91 98765 43210",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_REGULAR,
                                                            color: themeController
                                                                    .isLightTheme
                                                                    .value
                                                                ? addressClickController1
                                                                        .two
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .black2
                                                                    : ColorResources
                                                                        .black2
                                                                : addressClickController1
                                                                        .two
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .white
                                                                    : ColorResources
                                                                        .white,
                                                          ),
                                                        ),
                                                        SizedBox(height: 12),
                                                        Text(
                                                          "Building No,66, 78th Main Road, 100ft\nRoad, Indiranagar, Bangalore 123456",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_REGULAR,
                                                            color: themeController
                                                                    .isLightTheme
                                                                    .value
                                                                ? addressClickController1
                                                                        .two
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .black9
                                                                    : ColorResources
                                                                        .black9
                                                                : addressClickController1
                                                                        .two
                                                                        .isTrue
                                                                    ? ColorResources
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6)
                                                                    : ColorResources
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: InkWell(
                                              onTap: () {
                                                //Get.off(ConfirmAddressScreen());
                                                Get.back();
                                              },
                                              child: Container(
                                                height: 50,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                  color: ColorResources.blue1,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Confirm Address",
                                                    style: TextStyle(
                                                      fontFamily: TextFontFamily
                                                          .SEN_BOLD,
                                                      fontSize: 20,
                                                      color:
                                                          ColorResources.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  backgroundColor:
                                      themeController.isLightTheme.value
                                          ? ColorResources.white
                                          : ColorResources.black4,
                                );
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 16,
                                  color: ColorResources.blue1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Building No,66, 78th Main Road, 100ft Road, Indiranagar, Bangalore 123456\nMobile: 98765 43210",
                          style: TextStyle(
                            height: 1.4,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            fontSize: 13,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black.withOpacity(0.6)
                                : ColorResources.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 170,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value
                          ? ColorResources.blue3
                          : ColorResources.black10,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Details",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 16,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black
                                  : ColorResources.white,
                            ),
                          ),
                          row("Subtotal:", "\$2,850.00"),
                          row("Taxes:", "\$40.00"),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: ColorResources.black9,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  fontSize: 15,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                              Text(
                                "\$2,890.00",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 15,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: InkWell(
                  onTap: () {
                    Get.off(PaymentScreen());
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: ColorResources.blue1,
                    ),
                    child: Center(
                      child: Text(
                        "Continue to Payment",
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
