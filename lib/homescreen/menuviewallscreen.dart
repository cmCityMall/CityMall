import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/menu_view_all_screen_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/notificationscreen/notificationscreen.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MenuViewAllScreen extends StatefulWidget {
  MenuViewAllScreen({Key? key}) : super(key: key);

  @override
  State<MenuViewAllScreen> createState() => _MenuViewAllScreenState();
}

class _MenuViewAllScreenState extends State<MenuViewAllScreen> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    Get.put(MenuViewAllScreenController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MenuViewAllScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final MenuViewAllScreenController menuController = Get.find();
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
          "Categories",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.off(NotificationScreen());
              },
              child: SvgPicture.asset(
                Images.notification,
                color: themeController.isLightTheme.value
                    ? ColorResources.white3
                    : ColorResources.white.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              final list = dataController.menuMainCategories;
              return Expanded(
                child: GridView.builder(
                    controller: menuController.scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final cat = list[index];
                      return InkWell(
                        onTap: () {
                          ///Make Sure To Do Require Function*/
                          dataController.setSelectedMain(
                            cat.id,
                            cat.name,
                          );
                          dataController.getInitialSubCategories(cat.id);
                          dataController.getSliderProducts(cat.id);
                          dataController.getInitialDiscountProducts(cat.id);
                          dataController.getInitialPopularProducts(cat.id);
                          dataController.getInitialNewProducts(cat.id);
                          Get.off(() => CameraDeshBoard());
                        },
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image.network(cat.image)),
                                const SizedBox(height: 8),
                                Text(
                                  cat.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
            //Loading
            Obx(() => menuController.isLoading.value
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    height: 35,
                    width: 35,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
