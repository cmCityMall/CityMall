import 'package:citymall/admin/advertisement/bin/ad_binding.dart';
import 'package:citymall/admin/brand/bin/brand_binding.dart';
import 'package:citymall/admin/brand/view/brand_view.dart';
import 'package:citymall/admin/main_category/bin/mc_binding.dart';
import 'package:citymall/admin/main_category/view/mc_view.dart';
import 'package:citymall/admin/orders/bin/order_main_binding.dart';
import 'package:citymall/admin/orders/order_main_view.dart';
import 'package:citymall/admin/product/bin/product_binding.dart';
import 'package:citymall/admin/product/view/manage_product.dart';
import 'package:citymall/admin/shop/bin/shop_binding.dart';
import 'package:citymall/admin/shop/view/shop_view.dart';
import 'package:citymall/admin/sub_category/bin/sc_binding.dart';
import 'package:citymall/admin/sub_category/view/sc_view.dart';
import 'package:citymall/admin/time_sale/bin/time_sale_binding.dart';
import 'package:citymall/admin/week_promotion/bin/week_promotion_binding.dart';
import 'package:citymall/admin/week_promotion/view/week_promotion_view.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/menuviewallscreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/menuscreens/aboutusscreen.dart';
import 'package:citymall/menuscreens/languegescreen.dart';
import 'package:citymall/menuscreens/profilescreen/profilescreen.dart';
import 'package:citymall/menuscreens/settingscreens/settingscreen.dart';
import 'package:citymall/myorderscreen/myorder_screen_binding.dart';
import 'package:citymall/myorderscreen/tabscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../admin/advertisement/view/ad_view.dart';
import '../admin/time_sale/view/time_sale_view.dart';
import '../splashscreen/splash.dart';

class MenuPage extends GetView {
  MenuPage({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  InkWell inkwell(String image, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(image),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 14,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white12
          : ColorResources.black1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Obx(() {
              final user = authController.currentUser.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(user?.image ?? ""),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(height: 12),
                  Text(
                    user?.userName ?? "",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 16,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  Text(
                    user?.emailAddress ?? "",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontSize: 14,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  inkwell(Images.profileicon, "My profile", () {
                    Get.off(ProfileScreen());
                  }),
                  inkwell(Images.languegeicon, "Language", () {
                    Get.off(LangueageScreen());
                  }),
                  //Admin Panel
                  Obx(() {
                    final isAdmin =
                        authController.currentUser.value!.status! > 1;
                    if (!isAdmin) {
                      return const SizedBox();
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        inkwell(Images.categoryicon, "Manage Advertisement",
                            () {
                          Get.to(
                            () => const AdView(),
                            binding: ADBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Week Promotions",
                            () {
                          Get.to(
                            () => const WeekPromotionView(),
                            binding: WeekPromotionBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Flash Sales", () {
                          Get.to(
                            () => const TimeSaleView(),
                            binding: TimeSaleBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Main Category",
                            () {
                          Get.to(
                            () => const MCView(),
                            binding: MCBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Sub Category", () {
                          Get.to(
                            () => const SCView(),
                            binding: SCBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Shop", () {
                          Get.to(
                            () => const ShopView(),
                            binding: ShopBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Brand", () {
                          Get.to(
                            () => const BrandView(),
                            binding: BrandBinding(),
                          );
                        }),
                        inkwell(Images.categoryicon, "Manage Product", () {
                          Get.to(
                            () => const ManageProduct(),
                            binding: ProductBinding(),
                          );
                        }),
                        inkwell(Images.myordericon, "Manage Orders", () {
                          Get.to(
                            () => OrderMainView(),
                            binding: OrderMainBinding(),
                          );
                        })
                      ],
                    );
                  }),
                  inkwell(Images.categoryicon, "All Categories", () {
                    Get.off(MenuViewAllScreen());
                  }),
                  Obx(() {
                    final isNotAdmin =
                        authController.currentUser.value!.status! == 1;
                    return isNotAdmin
                        ? inkwell(Images.myordericon, "My Order", () {
                            Get.to(
                              () => MyOrderScreen(),
                              binding: MyOrderScreenBinding(),
                            );
                          })
                        : const SizedBox();
                  }),
                  inkwell(Images.settingicon, "Settings", () {
                    Get.off(SettingScreen());
                  }),
                  inkwell(Images.aboutusicon, "About Us", () {
                    Get.off(AboutUsScreen());
                  }),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      authController.logOut();
                      Get.off(SplashScreen());
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorResources.blue1,
                      ),
                      child: const Center(
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_BOLD,
                            fontSize: 14,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
