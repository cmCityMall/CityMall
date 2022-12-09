import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors.dart';
import '../../controller/theme_controller.dart';
import '../../textstylefontfamily/textfontfamily.dart';
import 'reward_product_widget.dart';

class RewardProductViewAll extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  RewardProductViewAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
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
          "Reward Products",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: dataController.rewardProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: RewardProductWidget(
              product: dataController.rewardProducts[index],
            ),
          );
        },
      ),
    );
  }
}
