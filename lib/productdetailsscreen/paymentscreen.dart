import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/addnewcardscreen.dart';
import 'package:citymall/productdetailsscreen/confirmaddressscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ThemeController themeController = Get.put(ThemeController());

  bool isSelected1 = false;

  bool isSelected2 = false;

  bool isSelected3 = false;

  bool isSelected4 = false;

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
              Get.off(ConfirmAddressScreen());
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
          "Payment",
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
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your payment\nmethod",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 24,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black2
                            : ColorResources.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected1 == true ||
                              isSelected2 == true ||
                              isSelected3 == true ||
                              isSelected4 == true) {
                            isSelected1 = false;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                          }
                          isSelected1 = true;
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: ColorResources.black11,
                                      borderRadius: BorderRadius.circular(13),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Images.creditdebit,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Credit / Debit Card",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height:
                                  36 /*MediaQuery.of(context).size.height/24.75*/ /*36*/,
                              width: 36,
                              decoration: BoxDecoration(
                                color: isSelected1 == true
                                    ? ColorResources.blue1
                                    : ColorResources.blue1.withOpacity(0.06),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected1 == true
                                      ? Colors.transparent
                                      : ColorResources.blue1,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: isSelected1 == true
                                    ? ColorResources.white
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        height:
                            MediaQuery.of(context).size.height / 12.72 /*70*/,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                25.45 /*35*/),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            bottom: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            left: 24,
                            right: 24),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected1 == true
                                ? ColorResources.blue1
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected1 == true ||
                              isSelected2 == true ||
                              isSelected3 == true ||
                              isSelected4 == true) {
                            isSelected1 = false;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                          }
                          isSelected2 = true;
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: ColorResources.black11,
                                      borderRadius: BorderRadius.circular(13),
                                      image: DecorationImage(
                                        image: AssetImage(Images.cashondeliver),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Cash On Delivery",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height:
                                  36 /*MediaQuery.of(context).size.height/24.75*/ /*36*/,
                              width: 36,
                              decoration: BoxDecoration(
                                color: isSelected2 == true
                                    ? ColorResources.blue1
                                    : ColorResources.blue1.withOpacity(0.06),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected2 == true
                                      ? Colors.transparent
                                      : ColorResources.blue1,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: isSelected2 == true
                                    ? ColorResources.white
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        height:
                            MediaQuery.of(context).size.height / 12.72 /*70*/,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                25.45 /*35*/),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            bottom: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            left: 24,
                            right: 24),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected2 == true
                                ? ColorResources.blue1
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected1 == true ||
                              isSelected2 == true ||
                              isSelected3 == true ||
                              isSelected4 == true) {
                            isSelected1 = false;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                          }
                          isSelected3 = true;
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: ColorResources.black11,
                                      borderRadius: BorderRadius.circular(13),
                                      image: DecorationImage(
                                        image: AssetImage(Images.paypal),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Paypal",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height:
                                  36 /*MediaQuery.of(context).size.height/24.75*/ /*36*/,
                              width: 36,
                              decoration: BoxDecoration(
                                color: isSelected3 == true
                                    ? ColorResources.blue1
                                    : ColorResources.blue1.withOpacity(0.06),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected3 == true
                                      ? Colors.transparent
                                      : ColorResources.blue1,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: isSelected3 == true
                                    ? ColorResources.white
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        height:
                            MediaQuery.of(context).size.height / 12.72 /*70*/,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                25.45 /*35*/),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            bottom: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            left: 24,
                            right: 24),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected3 == true
                                ? ColorResources.blue1
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected1 == true ||
                              isSelected2 == true ||
                              isSelected3 == true ||
                              isSelected4 == true) {
                            isSelected1 = false;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                          }
                          isSelected4 = true;
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: ColorResources.black11,
                                      borderRadius: BorderRadius.circular(13),
                                      image: DecorationImage(
                                        image: AssetImage(Images.googlewallet),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Google Wallet",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height:
                                  36 /*MediaQuery.of(context).size.height/24.75*/ /*36*/,
                              width: 36,
                              decoration: BoxDecoration(
                                color: isSelected4 == true
                                    ? ColorResources.blue1
                                    : ColorResources.blue1.withOpacity(0.06),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected4 == true
                                      ? Colors.transparent
                                      : ColorResources.blue1,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: isSelected4 == true
                                    ? ColorResources.white
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        height:
                            MediaQuery.of(context).size.height / 12.72 /*70*/,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                25.45 /*35*/),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            bottom: MediaQuery.of(context).size.height /
                                52.41 /*17*/,
                            left: 24,
                            right: 24),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected4 == true
                                ? ColorResources.blue1
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Get.off(AddNewCardScreen());
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          border: Border.all(color: ColorResources.blue1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "+ Add New Card",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 16,
                              color: ColorResources.blue1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "",
                      titlePadding: EdgeInsets.zero,
                      content: Column(
                        children: [
                          Image.asset(Images.paymentSuccess,
                              height: 120, width: 120),
                          SizedBox(height: 20),
                          Text(
                            "Yuppy!!",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 27,
                              color: ColorResources.black2,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Your Payment Recive to Seller",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 14,
                              color: ColorResources.black,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: ColorResources.blue1,
                    ),
                    child: Center(
                      child: Text(
                        "Pay",
                        style: TextStyle(
                          fontFamily: TextFontFamily.SEN_BOLD,
                          fontSize: 20,
                          color: ColorResources.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
