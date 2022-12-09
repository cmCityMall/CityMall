import 'package:citymall/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors.dart';
import '../../controller/theme_controller.dart';
import '../../textstylefontfamily/textfontfamily.dart';
import '../other/cache_image.dart';

class RewardCartList extends StatelessWidget {
  const RewardCartList({
    Key? key,
    required this.themeController,
  }) : super(key: key);
  final ThemeController themeController;
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cartController.rewardCartMap.entries.map((e) {
        final product = e.value;
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorResources.white6,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomCacheNetworkImage(
                    imageUrl: e.value.image,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: TextFontFamily.SEN_BOLD,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black2
                            : ColorResources.white,
                      ),
                    ),
                  ),
                  Text(
                    "${product.requiredPoint} points",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontWeight: FontWeight.w800,
                      color: ColorResources.blue1,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  //Increase
                  IconButton(
                    onPressed: () => cartController.addToRewardCart(product),
                    icon: Container(
                      decoration: const BoxDecoration(
                          color: ColorResources.blue1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: const Icon(
                        Icons.add,
                        color: ColorResources.white,
                        size: 22,
                      ),
                    ),
                  ),
                  //Count Text
                  Text(
                    "${product.count}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: TextFontFamily.SEN_BOLD,
                      color: ColorResources.black,
                    ),
                  ),
                  //Decrease
                  IconButton(
                    onPressed: () =>
                        cartController.removeFromRewardCart(product),
                    icon: Container(
                      decoration: const BoxDecoration(
                          color: ColorResources.blue1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: const Icon(
                        Icons.remove,
                        color: ColorResources.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
