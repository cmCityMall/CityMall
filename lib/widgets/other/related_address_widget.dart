import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../colors/colors.dart';
import '../../controller/clickcontroller.dart';
import '../../controller/theme_controller.dart';
import '../../images/images.dart';
import '../../productdetailsscreen/addaddressscreen.dart';
import '../../productdetailsscreen/confirmaddressscreen.dart';
import '../../textstylefontfamily/textfontfamily.dart';

class RelatedAddressWidget extends StatelessWidget {
  const RelatedAddressWidget({
    Key? key,
    required this.themeController,
    required this.addressClickController1,
  }) : super(key: key);

  final ThemeController themeController;
  final AddressClickController1 addressClickController1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50,
            width: Get.width,
            color: themeController.isLightTheme.value
                ? ColorResources.white11
                : ColorResources.black1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saved Address",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: TextFontFamily.SEN_BOLD,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(AddAddressScreen());
                    },
                    child: Text(
                      "Add New Address",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: TextFontFamily.SEN_BOLD,
                        color: ColorResources.blue1,
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
                if (addressClickController1.one.isTrue ||
                    addressClickController1.two.isTrue) {
                  addressClickController1.one(false);
                  addressClickController1.two(false);
                }
                addressClickController1.one(true);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  height: 165,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: themeController.isLightTheme.value
                        ? addressClickController1.one.isTrue
                            ? ColorResources.lightgreen
                            : ColorResources.white
                        : addressClickController1.one.isTrue
                            ? ColorResources.black6
                            : ColorResources.black6,
                    border: Border.all(
                      width: 1,
                      color: themeController.isLightTheme.value
                          ? addressClickController1.one.isTrue
                              ? ColorResources.green1
                              : ColorResources.grey11
                          : addressClickController1.one.isTrue
                              ? ColorResources.blue1
                              : ColorResources.black5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.homefill,
                              height: 15,
                              width: 15,
                              color: themeController.isLightTheme.value
                                  ? addressClickController1.one.isTrue
                                      ? ColorResources.green1
                                      : ColorResources.black2
                                  : addressClickController1.one.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Home Address",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? addressClickController1.one.isTrue
                                        ? ColorResources.green1
                                        : ColorResources.black2
                                    : addressClickController1.one.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          " John Doe",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: TextFontFamily.SEN_BOLD,
                            color: themeController.isLightTheme.value
                                ? addressClickController1.one.isTrue
                                    ? ColorResources.black2
                                    : ColorResources.black2
                                : addressClickController1.one.isTrue
                                    ? ColorResources.white
                                    : ColorResources.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "+91 12345 67890",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? addressClickController1.one.isTrue
                                    ? ColorResources.black2
                                    : ColorResources.black2
                                : addressClickController1.one.isTrue
                                    ? ColorResources.white
                                    : ColorResources.white,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Building No,66, 78th Main Road, 100ft\nRoad, Indiranagar, Bangalore 123456",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? addressClickController1.one.isTrue
                                    ? ColorResources.black9
                                    : ColorResources.black9
                                : addressClickController1.one.isTrue
                                    ? ColorResources.white.withOpacity(0.6)
                                    : ColorResources.white.withOpacity(0.6),
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
                if (addressClickController1.one.isTrue ||
                    addressClickController1.two.isTrue) {
                  addressClickController1.one(false);
                  addressClickController1.two(false);
                }
                addressClickController1.two(true);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 165,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: themeController.isLightTheme.value
                        ? addressClickController1.two.isTrue
                            ? ColorResources.lightgreen
                            : ColorResources.white
                        : addressClickController1.two.isTrue
                            ? ColorResources.black6
                            : ColorResources.black6,
                    border: Border.all(
                      width: 1,
                      color: themeController.isLightTheme.value
                          ? addressClickController1.two.isTrue
                              ? ColorResources.green1
                              : ColorResources.grey11
                          : addressClickController1.two.isTrue
                              ? ColorResources.blue1
                              : ColorResources.black5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.office,
                              height: 15,
                              width: 15,
                              color: themeController.isLightTheme.value
                                  ? addressClickController1.two.isTrue
                                      ? ColorResources.green1
                                      : ColorResources.black2
                                  : addressClickController1.two.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Office Address",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? addressClickController1.two.isTrue
                                        ? ColorResources.green1
                                        : ColorResources.black2
                                    : addressClickController1.two.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          " John Doe",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: TextFontFamily.SEN_BOLD,
                            color: themeController.isLightTheme.value
                                ? addressClickController1.two.isTrue
                                    ? ColorResources.black2
                                    : ColorResources.black2
                                : addressClickController1.two.isTrue
                                    ? ColorResources.white
                                    : ColorResources.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "+91 98765 43210",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? addressClickController1.two.isTrue
                                    ? ColorResources.black2
                                    : ColorResources.black2
                                : addressClickController1.two.isTrue
                                    ? ColorResources.white
                                    : ColorResources.white,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Building No,66, 78th Main Road, 100ft\nRoad, Indiranagar, Bangalore 123456",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? addressClickController1.two.isTrue
                                    ? ColorResources.black9
                                    : ColorResources.black9
                                : addressClickController1.two.isTrue
                                    ? ColorResources.white.withOpacity(0.6)
                                    : ColorResources.white.withOpacity(0.6),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Get.off(ConfirmAddressScreen());
              },
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: ColorResources.blue1,
                ),
                child: Center(
                  child: Text(
                    "Confirm Address",
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
