import 'package:citymall/address_form_screen/bin/address_form_binding.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/hive_personal_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../address_form_screen/controller/address_controller.dart';
import '../../address_form_screen/view/addaddressscreen.dart';
import '../../colors/colors.dart';
import '../../constant/constant.dart';
import '../../controller/cart_controller.dart';
import '../../controller/theme_controller.dart';
import '../../images/images.dart';
import '../../productdetailsscreen/confirmaddressscreen.dart';
import '../../textstylefontfamily/textfontfamily.dart';

class RelatedAddressWidget extends StatelessWidget {
  const RelatedAddressWidget({
    Key? key,
    required this.themeController,
  }) : super(key: key);

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final CartController cartController = Get.find();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50,
            width: Get.width,
            color: themeController.isLightTheme.value
                ? ColorResources.white11
                : ColorResources.black1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  /* Text(
                    "Saved Address",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: TextFontFamily.SEN_BOLD,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ), */
                  InkWell(
                    onTap: () {
                      dataController.setSelectedHivePersonalAddress(null);
                      Get.to(() => AddAddressScreen(),
                          binding: AddressFormBinding());
                    },
                    child: const Text(
                      "Add New Address",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: TextFontFamily.SEN_BOLD,
                        color: ColorResources.blue1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box<HivePersonalAddress>(addressBox).listenable(),
              builder: (context, Box<HivePersonalAddress> box, __) {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: box.values.map((e) {
                    return Obx(
                      () => ChildAddressContainer(
                        themeController: themeController,
                        hivePerson: e,
                        isSelected:
                            dataController.selectedAddressId.value == e.id,
                        selected: dataController.setSelectedAddressId,
                      ),
                    );
                  }).toList(),
                );
              }),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<HivePersonalAddress>(addressBox).listenable(),
                builder: (context, Box<HivePersonalAddress> box, __) {
                  final selectedHP = box.values.where((element) =>
                      element.id == dataController.selectedAddressId.value);
                  return InkWell(
                    onTap: () {
                      if (selectedHP.isNotEmpty) {
                        cartController
                            .setSelectedHivePersonalAddress(selectedHP.first);
                        Get.to(() => ConfirmAddressScreen());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: ColorResources.blue1,
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm Address",
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_BOLD,
                            fontSize: 20,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ChildAddressContainer extends StatelessWidget {
  const ChildAddressContainer({
    Key? key,
    required this.themeController,
    required this.hivePerson,
    required this.isSelected,
    required this.selected,
  }) : super(key: key);

  final ThemeController themeController;
  final HivePersonalAddress hivePerson;
  final void Function(String id, String value) selected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selected(hivePerson.id, hivePerson.address),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          height: 165,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: themeController.isLightTheme.value
                ? isSelected
                    ? ColorResources.lightgreen
                    : ColorResources.white
                : isSelected
                    ? ColorResources.black6
                    : ColorResources.black6,
            border: Border.all(
              width: 1,
              color: themeController.isLightTheme.value
                  ? isSelected
                      ? ColorResources.green1
                      : ColorResources.grey11
                  : isSelected
                      ? ColorResources.blue1
                      : ColorResources.black5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Images.homefill,
                      height: 15,
                      width: 15,
                      color: themeController.isLightTheme.value
                          ? isSelected
                              ? ColorResources.green1
                              : ColorResources.black2
                          : isSelected
                              ? ColorResources.blue1
                              : ColorResources.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      hivePerson.addressType == 0
                          ? "Home Address"
                          : "Office Address",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: TextFontFamily.SEN_BOLD,
                        color: themeController.isLightTheme.value
                            ? isSelected
                                ? ColorResources.green1
                                : ColorResources.black2
                            : isSelected
                                ? ColorResources.blue1
                                : ColorResources.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  hivePerson.fullName,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: TextFontFamily.SEN_BOLD,
                    color: themeController.isLightTheme.value
                        ? isSelected
                            ? ColorResources.black2
                            : ColorResources.black2
                        : isSelected
                            ? ColorResources.white
                            : ColorResources.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "${hivePerson.phoneNumber}",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    color: themeController.isLightTheme.value
                        ? isSelected
                            ? ColorResources.black2
                            : ColorResources.black2
                        : isSelected
                            ? ColorResources.white
                            : ColorResources.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  hivePerson.address,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    color: themeController.isLightTheme.value
                        ? isSelected
                            ? ColorResources.black9
                            : ColorResources.black9
                        : isSelected
                            ? ColorResources.white.withOpacity(0.6)
                            : ColorResources.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
