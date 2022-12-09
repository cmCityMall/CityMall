import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/model/purchase.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TrackOrderScreen2 extends StatelessWidget {
  final Purchase purchase;
  final int amt;
  TrackOrderScreen2({
    Key? key,
    required this.purchase,
    required this.amt,
  }) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

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
              //Get.off(MyOrderScreen());
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
          "My Order Detail",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(purchase.dateTime),
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontSize: 17,
                      color: themeController.isLightTheme.value
                          ? ColorResources.grey4
                          : ColorResources.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Id: ${purchase.id.substring(0, 5)}",
                        style: TextStyle(
                          fontFamily: TextFontFamily.SEN_REGULAR,
                          fontSize: 17,
                          color: themeController.isLightTheme.value
                              ? ColorResources.grey4
                              : ColorResources.white.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        "Amt: $amt MMK",
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
                  const SizedBox(height: 20),
                  const Divider(thickness: 0.5, color: ColorResources.grey4),
                  const SizedBox(height: 20),
                  Text(
                    "ETA: ${purchase.eta}",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 19,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "Items Detail: ",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 19,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  !(purchase.items == null)
                      ? Container(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: purchase.items!.length,
                            itemBuilder: (context, index) {
                              final item = purchase.items![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorResources.blue1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    item.color == null
                                        ? const SizedBox()
                                        : Text(
                                            "Color: ",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 16,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                    item.color == null
                                        ? const SizedBox()
                                        : Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.white9
                                                  : ColorResources.black1,
                                            ),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 9,
                                                backgroundColor:
                                                    HexColor(item.color!),
                                              ),
                                            ),
                                          ),
                                    //Size
                                    item.size == null
                                        ? const SizedBox()
                                        : Text(
                                            "Size: ${item.size}",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 16,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                  ],
                                ),
                                trailing: Text(
                                  "${item.lastPrice * item.count}MMK",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  //Reward Product.............//
                  Text(
                    "Reward Items Detail: ",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 19,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  !(purchase.rewardProducts == null)
                      ? Container(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: purchase.rewardProducts!.length,
                            itemBuilder: (context, index) {
                              final item = purchase.rewardProducts![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorResources.blue1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                trailing: Text(
                                  "${item.requiredPoint * item.count} points",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  //........................//
                  Text(
                    "Delivery Fee:  ${purchase.townShipNameAndFee["fee"]}MMK",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 18,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black3
                          : ColorResources.white,
                    ),
                  ),
                  SizedBox(height: Get.height >= 805 ? 50 : 20),
                  Container(
                    height: 115,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black13,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: ColorResources.blue1.withOpacity(0.05),
                          spreadRadius: 0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            themeController.isLightTheme.value
                                ? Images.trackhomeimage
                                : Images.darktrackhomeimage,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 18,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black3
                                        : ColorResources.white,
                                  ),
                                ),
                                Text(
                                  "Home, Work & Other Address",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey15.withOpacity(0.6)
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  purchase.personalAddress.address,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 14,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey15.withOpacity(0.6)
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
