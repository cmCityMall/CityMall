import 'package:citymall/categorybrandscreen/subcategory1.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/category_brand_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryBrandScreen extends StatelessWidget {
  CategoryBrandScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final CategoryBrandController categoryBrandController = Get.find();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Obx(() {
                  final list = dataController.brandRxList;
                  if (list.isEmpty) {
                    return const EmptyWidget("No brands yet.");
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      controller: categoryBrandController.scrollController,
                      itemBuilder: (context, index) {
                        final brand = list[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              dataController.setSelectedBrand(brand);
                              dataController.getInitialBrandProducts(brand.id);
                              Get.to(() => const BrandsDetailView());
                            },
                            child: Container(
                              height: 141,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    brand.image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  brand.name,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                    color: ColorResources.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                //Loading
                Obx(() => categoryBrandController.isLoading.value
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
        ),
      ),
    );
  }
}
