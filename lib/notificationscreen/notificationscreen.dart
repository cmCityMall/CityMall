import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  final List<Map> notificationList = [
    {
      "image": Images.heart,
      "midtext": "Your order is confirm,check a your order status.",
      "lasttext": "9.24 Am",
      "color": ColorResources.green,
    },
    {
      "image": Images.chat,
      "midtext": "Justas Galaburda6:30 AM,Yesterday6:30 AM, Yesterday",
      "lasttext": "10.00 pm",
      "color": ColorResources.purple,
    },
    {
      "image": Images.line,
      "midtext": "Eric Holfman2 hrs ago2 hrs ago",
      "lasttext": "12.20 Am",
      "color": ColorResources.skyblue,
    },
    {
      "image": Images.heart,
      "midtext": "Justas Galaburda5 hrs ago5 hrs ago",
      "lasttext": "2.00 pm",
      "color": ColorResources.green,
    },
    {
      "image": Images.chat,
      "midtext": "Eric Holfman10 hrs ago10 hrs ago",
      "lasttext": "3.00 Am",
      "color": ColorResources.purple,
    },
    {
      "image": Images.line,
      "midtext": "Charles Patterson12 hrs ago12 hrs ago",
      "lasttext": "5.00 pm",
      "color": ColorResources.skyblue,
    },
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
              selectedIndex = 0;
              Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) => NavigationBarBottom(),
              ));
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
          "Notification",
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
                itemCount: notificationList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: notificationList[index]["color"],
                      child: SvgPicture.asset(notificationList[index]["image"]),
                    ),
                    title: Text(
                      notificationList[index]["midtext"],
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: TextFontFamily.SEN_REGULAR,
                          color: themeController.isLightTheme.value
                              ? ColorResources.black3
                              : ColorResources.white),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        notificationList[index]["lasttext"],
                        // maxLines: 2,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: "PoppinsRegular",
                            color: themeController.isLightTheme.value
                                ? ColorResources.grey8
                                : ColorResources.white.withOpacity(0.6)),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
