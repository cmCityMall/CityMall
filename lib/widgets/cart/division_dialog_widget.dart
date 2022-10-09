import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/cart_controller.dart';
import 'package:citymall/widgets/cart/township_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/division_list.dart';

class DivisionDialogWidget extends StatelessWidget {
  const DivisionDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.center,
        child: GetBuilder<CartController>(builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(),
                bottom: BorderSide(),
                left: BorderSide(),
                right: BorderSide(),
              ),
            ),
            width: 250,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: divisionList.length,
              itemBuilder: (context, divisionIndex) {
                return MouseRegion(
                  onHover: (event) {
                    controller.changeMouseIndex(divisionIndex);
                    showDialog(
                      context: context,
                      barrierColor: Colors.white.withOpacity(0),
                      builder: (context) {
                        return TownshipDialogWidget(
                            division: divisionList[divisionIndex]);
                      },
                    );
                  },
                  onExit: (event) {
                    // controller
                    //   .changeMouseIndex(0);
                    Navigator.of(context).pop();
                  },
                  child: AnimatedContainer(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    color: controller.mouseIndex == divisionIndex
                        ? ColorResources.blue1
                        : Colors.white,
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text
                          Text(
                            divisionList[divisionIndex].name,
                            style: TextStyle(
                              color: controller.mouseIndex == divisionIndex
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(FontAwesomeIcons.angleRight),
                        ]),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
