import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/tabcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/myorderscreen/trackorderscreens/trakorderscreen1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveredListScreen extends StatelessWidget {
  DeliveredListScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final TabviewController controller = Get.put(TabviewController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              height: 180,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeController.isLightTheme.value
                    ? ColorResources.white
                    : ColorResources.black13,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    color: ColorResources.black12.withOpacity(0.2),
                    spreadRadius: 0,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Id: 5t36-9iu2",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 16,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black2
                                  : ColorResources.white,
                            ),
                          ),
                          Text(
                            "Wed, 12 Sep",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 14,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.grey14
                                  : ColorResources.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.5, color: ColorResources.grey14),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Quantity: ",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 16,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.grey14
                                      : ColorResources.white.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                "03",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 16,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Total Amount: ",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 16,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.grey14
                                      : ColorResources.white.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                "\$2,890",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 16,
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
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(TrackOrderScreen1());
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                                color: ColorResources.blue1,
                              ),
                              child: Center(
                                child: Text(
                                  "Detail",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 16,
                                    color: ColorResources.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Delivered",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 16,
                              color: ColorResources.green1,
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
        },
      ),
    );
  }
}
