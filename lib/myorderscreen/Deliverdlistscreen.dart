import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/tabcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/model/purchase.dart';
import 'package:citymall/myorderscreen/my_order_screen_controller.dart';
import 'package:citymall/myorderscreen/trackorderscreens/trackorder2.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/widgets/loading_widget.dart';

class DeliveredListScreen extends StatelessWidget {
  DeliveredListScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final TabviewController controller = Get.put(TabviewController());

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final MyOrderScreenController orderController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Obx(() {
        if (orderController.isLoading.value) {
          return const LoadingWidget();
        }
        if (orderController.deliveredList.isEmpty) {
          return const EmptyWidget("No delivered orders yet.");
        }
        return ListView.builder(
          itemCount: orderController.deliveredList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final purchase = orderController.deliveredList[index];
            final quantity = getQuantity(purchase);
            final totalAmount =
                getTotalAmount(purchase) + purchase.townShipNameAndFee["fee"];
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
                              "Order Id: ${purchase.id.substring(0, 5)}",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_BOLD,
                                fontSize: 16,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMMd().format(purchase.dateTime),
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
                      const SizedBox(height: 10),
                      const Divider(
                          thickness: 0.5, color: ColorResources.grey14),
                      const SizedBox(height: 15),
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
                                  "$quantity",
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
                                  "$totalAmount",
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
                                Get.to(() => TrackOrderScreen2(
                                      purchase: purchase,
                                      amt: totalAmount,
                                    ));
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                  color: ColorResources.blue1,
                                ),
                                child: const Center(
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
        );
      }),
    );
  }

  getQuantity(Purchase purchase) {
    int count = 0;
    if (!(purchase.items == null)) {
      for (var e in purchase.items!) {
        count += e.count;
      }
    }
    if (!(purchase.rewardProducts == null)) {
      for (var e in purchase.rewardProducts!) {
        count += e.count;
      }
    }
    return count;
  }

  getTotalAmount(Purchase purchase) {
    int total = 0;
    if (!(purchase.items == null)) {
      for (var e in purchase.items!) {
        total += e.lastPrice * e.count;
      }
    }
    return total;
  }
}
