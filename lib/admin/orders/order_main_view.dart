import 'package:citymall/admin/orders/canceled_order.dart';
import 'package:citymall/admin/orders/delivered_order.dart';
import 'package:citymall/admin/orders/procesing_order.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/tabcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderMainView extends StatelessWidget {
  final bool isPrepay;
  OrderMainView({Key? key, required this.isPrepay}) : super(key: key);
  final TabviewController controller = Get.put(TabviewController());
  final ThemeController themeController = Get.put(ThemeController());
  final List<Tab> myTabs = <Tab>[
    Tab(text: "Delivered"),
    Tab(text: "Processing"),
    Tab(text: "Canceled"),
  ];

  @override
  Widget build(BuildContext context) {
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Column(
            children: [
              TabBar(
                controller: controller.tabController,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: ColorResources.blue1,
                unselectedLabelColor: themeController.isLightTheme.value
                    ? ColorResources.grey14
                    : ColorResources.white.withOpacity(0.6),
                unselectedLabelStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: TextFontFamily.SEN_REGULAR,
                ),
                labelColor: themeController.isLightTheme.value
                    ? ColorResources.black2
                    : ColorResources.white,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: TextFontFamily.SEN_BOLD,
                ),
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 3.0, color: ColorResources.blue1),
                  insets: EdgeInsets.symmetric(horizontal: 50),
                ),
                tabs: myTabs,
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    DeliveredOrders(isPrepay: isPrepay),
                    ProcessingOrders(isPrepay: isPrepay),
                    CanceledOrder(isPrepay: isPrepay),
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
