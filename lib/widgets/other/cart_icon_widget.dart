import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../colors/colors.dart';
import '../../controller/cart_controller.dart';
import '../../controller/theme_controller.dart';
import '../../images/images.dart';
import '../../rout_screens/rout_1.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({
    Key? key,
    required this.themeController,
    this.color,
  }) : super(key: key);

  final ThemeController themeController;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return InkWell(
      onTap: () {
        selectedIndex = 4;
        Navigator.of(context, rootNavigator: true)
            .pushReplacement(MaterialPageRoute(
          builder: (context) => NavigationBarBottom(),
        ));
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: themeController.isLightTheme.value
              ? color ?? ColorResources.grey10
              : ColorResources.white.withOpacity(0.8),
        ),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                    radius: 10,
                    backgroundColor: ColorResources.blue1,
                    child: Obx(() {
                      final map = cartController.cartMap;
                      final rewardMap = cartController.rewardCartMap;
                      final count = map.length;
                      final rewardCount = rewardMap.length;
                      return Text("${count + rewardCount}",
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                          ));
                    }))),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  Images.cartblank,
                  color: ColorResources.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
