import 'package:citymall/controller/cart_controller.dart';
import 'package:citymall/widgets/other/related_address_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
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
  /* List<Map> bottomAddressList = [
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
 */
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
                    offset: const Offset(0, 4),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  RelatedAddressWidget(
                                      themeController: themeController),
                                  backgroundColor:
                                      themeController.isLightTheme.value
                                          ? ColorResources.white
                                          : ColorResources.black4,
                                );
                              },
                              child: const Text(
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
                          "${cartController.selectedHivePersonalAddress.value!.address}\nMobile: ${cartController.selectedHivePersonalAddress.value!.phoneNumber}",
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
                          row("Subtotal:", "${cartController.subTotal}"),
                          row("Taxes:",
                              " ${cartController.townShipNameAndFee["fee"]} MMK"),
                          const DottedLine(
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
                                "${cartController.subTotal.value + cartController.townShipNameAndFee["fee"]}MMK",
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
                    Get.to(() => const PaymentScreen());
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
