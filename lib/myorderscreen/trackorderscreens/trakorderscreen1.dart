import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TrackOrderScreen1 extends StatelessWidget {
  TrackOrderScreen1({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  List<Map> stepperLIst = [
    {
      "image": Images.track1,
      "text1": "Order Placed",
      "text2": "We have received your order , ",
      "text3": "10:04",
    },
    {
      "image": Images.track2,
      "text1": "Payment Confirmed",
      "text2": "Awaiting confirmation... , ",
      "text3": "10:06",
    },
    {
      "image": Images.track3,
      "text1": "Order Processed",
      "text2": "We are preparing your order. , ",
      "text3": "10:08",
    },
    {
      "image": Images.track4,
      "text1": "Ready to Pickup",
      "text2": "Order from SpingoShop , ",
      "text3": "11:00",
    },
  ];

  List<Map> darkStepperList = [
    {"image": Images.darktrack1},
    {"image": Images.darktrack2},
    {"image": Images.darktrack3},
    {"image": Images.darktrack4},
  ];

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
          "Track My Order",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wed, 12 Sep",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    fontSize: 17,
                    color: themeController.isLightTheme.value
                        ? ColorResources.grey4
                        : ColorResources.white.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order ID: 5t36-9iu2",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        fontSize: 17,
                        color: themeController.isLightTheme.value
                            ? ColorResources.grey4
                            : ColorResources.white.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      "Amt: \$2,890.00",
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
                SizedBox(height: 20),
                Divider(thickness: 0.5, color: ColorResources.grey4),
                SizedBox(height: 20),
                Text(
                  "ETA: 15 Min",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 19,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  color: themeController.isLightTheme.value
                      ? ColorResources.white1
                      : ColorResources.black1,
                  child: ListView.builder(
                    itemCount: stepperLIst.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, position) {
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: position == 0 ? 20 : 0),
                              child: Column(
                                verticalDirection: VerticalDirection.down,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: position <= 2
                                        ? Icon(
                                            Icons.check,
                                            size: 15,
                                            color: ColorResources.white,
                                          )
                                        : Container(),
                                    decoration: BoxDecoration(
                                      color: position <= 2
                                          ? ColorResources.blue1
                                          : ColorResources.blue1
                                              .withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: position <= 1
                                              ? ColorResources.blue1
                                              : ColorResources.blue1
                                                  .withOpacity(0.2),
                                          width: 3),
                                    ),
                                  ),
                                  position < stepperLIst.length - 1
                                      ? Container(
                                          height: 60,
                                          width: 2,
                                          color: position < 1
                                              ? ColorResources.blue1
                                              : ColorResources.blue1
                                                  .withOpacity(0.2),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: position == 0 ? 20 : 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 25,
                                    color: Colors.transparent,
                                    child: SvgPicture.asset(
                                      themeController.isLightTheme.value
                                          ? stepperLIst[position]["image"]
                                          : darkStepperList[position]["image"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stepperLIst[position]["text1"],
                                        style: TextStyle(
                                          fontFamily:
                                              TextFontFamily.SEN_REGULAR,
                                          fontSize: 16,
                                          color:
                                              themeController.isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            stepperLIst[position]["text2"],
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 12,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.grey15
                                                      .withOpacity(0.6)
                                                  : ColorResources.white
                                                      .withOpacity(0.6),
                                            ),
                                          ),
                                          Text(
                                            stepperLIst[position]["text3"],
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_BOLD,
                                              fontSize: 12,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.grey12
                                                  : ColorResources.white
                                                      .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                                "House No: 1234, 2nd Floor Sector 18,\nSilicon valey USA.",
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
    );
  }
}
